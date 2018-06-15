require 'test_helper'

module CKB
  class ChainTest < Minitest::Test
    def setup
      @chain = Chain.new
    end

    def test_new_chain
      assert_equal 0, @chain.genesis.height
      assert_equal SHA3::NULL, @chain.head.parent_hash
      assert_equal 0, @chain.head.height
      assert_equal SHA3::NULL, @chain.head.parent_hash
    end

    def test_add_block
      blk = Core::Block.build(@chain.genesis.hash, 1, Random.new.bytes(100))
      assert_equal 1, blk.height

      assert_equal 0, @chain.head.height
      @chain.add_block(blk)
      assert_equal 1, @chain.head.height
    end
  end
end
