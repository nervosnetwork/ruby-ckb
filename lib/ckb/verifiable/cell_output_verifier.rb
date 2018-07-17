module CKB
  module Verifiable
    class CellOutputVerifier
      class InvalidCapacity < StandardError; end
      class InvalidLockhash < StandardError; end

      def initialize(target)
        @target = target
      end

      def verify!
        raise InvalidCapacity, "capacity must be positive" unless @target.capacity > 0
        raise InvalidLockhash, "lockhash must be a hash within #{LOCKHASH_RANGE} bytes" unless LOCKHASH_RANGE.include?(@target.lockhash.size)
      end
    end
  end
end
