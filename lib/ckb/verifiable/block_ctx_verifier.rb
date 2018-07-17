module CKB
  module Verifiable
    class BlockCtxVerifier
      def initialize(blk, ctx)
        @blk = blk
        @ctx = ctx
      end

      def verify!
        HeaderCtxVerifier.new(@blk.header, @ctx).verify!
        verify_transactions!
      end

      def verify_transactions!
        txs = @blk.transactions.to_a
        txs.each_with_index do |tx, i|
          tx.verify!

          if i > 0
            tx.inputs.each {|input| CellInputCtxVerifier.new(input, @ctx).verify! }
          else
            verify_cellbase!(tx)
          end
        end

        #verify_capacity_invariant!(txs)
      end

      def verify_capacity_invariant!(txs)
        consumed_outputs = txs
          .map {|tx| tx.inputs.map {|input| @ctx.get_output_cell(input.previous_output) } }
          .inject([], &:+)
      end

      def verify_cellbase!(tx)
        raise InvalidCellbase, "block must include a cellbase transaction" if tx.nil?
        raise InvalidCellbase, "cellbase must include exactly one input" unless tx.inputs.size == 1
        raise InvalidCellbase, "cellbase input must point to null" unless tx.inputs.first.previous_output == Core::OutPoint::NULL
        raise InvalidCellbase, "cellbase must use block number as unlock prefix" unless Util.big_endian_to_int(tx.inputs.first.unlock) == @blk.number
        raise InvalidCellbase, "cellbase must include exactly one output" unless tx.outputs.size == 1
        raise InvalidCellbase, "cellbase reward too much" if tx.outputs.first.capacity > Economics.block_reward(@blk.number)
      end
    end
  end
end
