module CKB
  # CKB full node
  class Node
    def initialize
      @chain = Chain.new
      @miner = PoW::Miner.new
    end

    def run
      loop do
        # mine new block
        parent_header = @chain.head.header
        blk = Core::Block.build(parent_header.hash, parent_header.number+1)
        @miner.mine parent_header, blk.header

        # add new block to chain
        @chain.add_block(blk)
      end
    end
  end
end