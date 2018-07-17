module CKB
  # CKB full node
  class Node
    def initialize
      @chain = Chain.new
      @miner = PoW::Miner.new
    end

    def run
      # TODO: use real lockhash
      cellbase_lockhash = SHA3.random.to_s

      loop do
        parent_header = @chain.head.header
        blk = Core::Block.build_candidate parent_header, cellbase_lockhash

        # mine on new candidate
        @miner.mine parent_header, blk.header

        # add new block to chain
        @chain.add_block!(blk)
      end
    end
  end
end
