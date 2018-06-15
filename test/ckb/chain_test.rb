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

      blk = Core::Block.build(blk.hash, 2, Random.new.bytes(100))
      @chain.add_block(blk)
      assert_equal 2, @chain.head.height
      assert_equal 0, @chain.genesis.height
    end

    def test_find_block_by_hash
        blk1 = Core::Block.build(@chain.genesis.hash, 1, Random.new.bytes(5))
        blk2 = Core::Block.build(blk1.hash, 2, Random.new.bytes(6))
        @chain.add_block(blk1).add_block(blk2)

        assert_equal 1, @chain.find(blk1.hash).height
        assert_equal 2, @chain.find(blk2.hash).height
    end

    def test_find_block_by_height
        blk1 = Core::Block.build(@chain.genesis.hash, 1, Random.new.bytes(5))
        blk2 = Core::Block.build(blk1.hash, 2, Random.new.bytes(6))
        @chain.add_block(blk1).add_block(blk2)

        assert_equal blk1.hash, @chain.find(1).hash
        assert_equal blk2.hash, @chain.find(2).hash
    end
  end
end
