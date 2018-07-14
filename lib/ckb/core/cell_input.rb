module CKB
  module Core
    class CellInput
      def self.build_cellbase_input(blknum)
        new(previous_output: OutPoint::NULL, unlock: Util.int_to_big_endian(blknum))
      end

      def self.build(ophash, opindex, unlock)
        op = OutPoint.build(hash: ophash, index: opindex)
        new(previous_output: op, unlock: unlock).tap do |input|
          input.validate!
        end
      end

      def validate!
      end
    end
  end
end
