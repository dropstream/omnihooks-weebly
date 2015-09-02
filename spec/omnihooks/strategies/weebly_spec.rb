require 'spec_helper'

def make_env(path = '/hooks/weebly', props = {})
  {
    'REQUEST_METHOD' => 'POST',
    'PATH_INFO' => path,
    'rack.session' => {},
    'rack.input' => StringIO.new('test=true'),
  }.merge(props)
end

def read_request(file_name)
  File.open(File.expand_path("../../../fixtures/#{file_name}.json", __FILE__)).read
end

RSpec.describe OmniHooks::Strategies::Weebly do
  let(:app) do
    lambda { |_env| [404, {}, ['Awesome']] }
  end


  describe '#options' do
    subject { OmniHooks::Strategies::Weebly.new(nil) }

    it 'should have a name defined' do
      expect(subject.options.name).to eq('weebly')
    end
  end

  describe '#args' do
    it 'has expected arguments' do
      expect(OmniHooks::Strategies::Weebly.args).to eq([:consumer_secret])
    end
  end

  describe '#call' do
    let(:subscriber) { Proc.new { nil } }
    let(:strategy) { OmniHooks::Strategies::Weebly.new(app) }

    before(:each) do
      OmniHooks::Strategies::Weebly.configure do |events|
        events.subscribe('store.order.pay', subscriber)
      end
    end

    context 'with a matched event' do
      it 'should pass the event to the subscriber' do
        expect(subscriber).to receive(:call).with(a_hash_including('client_id', 'client_version', 'event', 'timestamp', 'data', 'hmac'))

        strategy.call(make_env('/hooks/weebly', {'rack.input' => StringIO.new(read_request('matching_event')) }))
      end
    end

    context 'with an unmatched event' do
      it 'should pass the event to the subscriber' do
        expect(subscriber).not_to receive(:call)

        strategy.call(make_env('/hooks/weebly', {'rack.input' => StringIO.new(read_request('unmatching_event')) }))
      end
    end

  end
end