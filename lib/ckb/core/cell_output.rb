module CKB
  module Core
    class CellOutput
      def self.build(capacity, lockhash)
        new(capacity: capacity, lockhash: lockhash)
      end

      include Verifiable::Methods

      private

      def _verifiers
        @_verifiers ||= [ Verifiable::CellOutputVerifier.new(self) ]
      end

    end
  end
end
