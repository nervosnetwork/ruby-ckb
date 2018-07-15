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
    end
  end
end
