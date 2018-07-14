module CKB
  module Core
    class CellInput
      def self.build_cellbase_input(blknum)
        new(previous_output: OutPoint::NULL, unlock: Util.int_to_big_endian(blknum))
      end
    end
  end
end
