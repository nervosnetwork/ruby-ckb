module CKB
  module Verifiable
    class HeaderVerifier
      class VersionError < StandardError; end

      def initialize(target)
        @target = target
      end

      def verify!
        raise VersionError, "header version must be #{Core::Header::VERSION}" if @target.version != Core::Header::VERSION
      end
    end
  end
end

