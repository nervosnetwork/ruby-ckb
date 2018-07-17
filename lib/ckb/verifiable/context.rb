module CKB
  module Verifiable
    class Context
      def initialize(chain)
        @chain = chain
      end

      def get_parent(blk)
        @chain.store.get_block blk.parent_hash
      end

      def get_parent_header(hdr)
        @chain.store.get_header hdr.parent_hash
      end

      def get_transaction(txid)
        @chain.store.get_transaction(txid)
      end

      def get_output_cell(outpoint)
        tx = get_transaction outpoint.txid
        raise InvalidOutpoint, "missing transaction for #{outpoint}" if tx.nil?

        output = tx.outputs[outpoint.index]
        raise InvalidOutpoint, "missing transaction output for #{outpoint}" if output.nil?

        output
      end

      def p1cs
        # TODO: need to consider p1 cells created by temporary txs
        @p1cs ||= @chain.p1cs
      end

    end
  end
end
