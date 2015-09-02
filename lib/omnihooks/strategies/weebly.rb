require 'omnihooks'
require 'multi_json'

module OmniHooks
  module Strategies
    class Weebly
      include OmniHooks::Strategy
      option :name, 'weebly'

      event do
        raw_info
      end

      event_type do
        raw_info['event']
      end

      private

      def raw_info
        @raw_info ||= MultiJson.decode(request.body)
      end
    end
  end
end