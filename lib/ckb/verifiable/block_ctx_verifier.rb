module CKB
  module Verifiable
    class BlockCtxVerifier
      class MissingCellbase < StandardError; end
      class InvalidCellbaseInput < StandardError; end
      class InvalidCellbaseOutput < StandardError; end

      def initialize(blk, ctx)
        @blk = blk
        @ctx = ctx
      end

      def verify!
        HeaderCtxVerifier.new(@blk.header, @ctx).verify!
        verify_cellbase!
        verify_p1cs!
      end

      def verify_cellbase!
        cellbase = @blk.transactions.first
        cellbase.verify!

        raise MissingCellbase, "block must include a cellbase transaction" if cellbase.nil?

        raise InvalidCellbaseInput, "cellbase must include exactly one input" unless cellbase.inputs.size == 1
        raise InvalidCellbaseInput, "cellbase input must point to null" unless cellbase.inputs.first.previous_output == Core::OutPoint::NULL
        raise InvalidCellbaseInput, "cellbase must use block number as unlock prefix" unless Util.big_endian_to_int(cellbase.inputs.first.unlock) == @blk.number

        raise InvalidCellbaseOutput, "cellbase must include exactly one output" unless cellbase.outputs.size == 1
        raise InvalidCellbaseOutput, "cellbase reward too much" if cellbase.outputs.first.capacity > Economics.block_reward(@blk.number)
      end

      def verify_p1cs!
      end

      def parent
        @parent ||= @ctx.get_parent(@blk)
      end
    end
  end
end
