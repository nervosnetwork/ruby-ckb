module CKB
  module Core
    class CellInput

      class <<self
        def build_cellbase_input(blknum)
          new(previous_output: OutPoint::NULL, unlock: Util.int_to_big_endian(blknum))
        end

        def build(txid, index, unlock)
          op = OutPoint.build(txid: txid, index: index)
          new(previous_output: op, unlock: unlock)
        end
      end

    end
  end
end
