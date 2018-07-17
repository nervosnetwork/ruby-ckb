module CKB
  module Verifiable
    class HeaderVerifier
      def initialize(target)
        @target = target
      end

      def verify!
        raise InvalidHeader, "header version must be #{Core::Header::VERSION}" if @target.version != Core::Header::VERSION
      end
    end
  end
end

