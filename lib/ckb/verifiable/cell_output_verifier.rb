module CKB
  module Verifiable
    class CellOutputVerifier

      def initialize(target)
        @target = target
      end

      def verify!
        raise InvalidCellOutput, "capacity must be positive" unless @target.capacity > 0
        raise InvalidCellOutput, "lockhash must be a hash within #{LOCKHASH_RANGE} bytes" unless LOCKHASH_RANGE.include?(@target.lockhash.size)
      end
    end
  end
end
