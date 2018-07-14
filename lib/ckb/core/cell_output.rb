module CKB
  module Core
    class CellOutput
      def self.build(capacity, lockhash)
        new(capacity: capacity, lockhash: lockhash).tap do |output|
          output.validate!
        end
      end

      def validate!
        raise ArgumentError, "capacity must be larger than 0" unless capacity > 0
        raise ArgumentError, "lockhash must be a hash within #{LOCKHASH_RANGE} bytes" unless LOCKHASH_RANGE.include?(lockhash.size)
      end

    end
  end
end
