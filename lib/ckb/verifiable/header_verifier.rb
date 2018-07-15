module CKB
  module Verifiable
    class HeaderVerifier
      class InvalidVersion < StandardError; end

      def initialize(target)
        @target = target
      end

      def verify!
        raise InvalidVersion, "header version must be #{Core::Header::VERSION}" if @target.version != Core::Header::VERSION
      end
    end
  end
end

