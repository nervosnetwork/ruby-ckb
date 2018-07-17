require 'test_helper'

module CKB
  class ChainTest < Minitest::Test
    def setup
      @chain = Chain.new
    end

    def test_new_chain
      assert_equal 0, @chain.genesis.number
      assert_equal SHA3::NULL, @chain.head.parent_hash
      assert_equal 0, @chain.head.number
      assert_equal SHA3::NULL, @chain.head.parent_hash
    end

    def test_add_block
      assert_equal 1, @chain.p1cs.size

      blk = Core::Block.build_candidate(@chain.genesis.header, SHA3.random.to_s, timestamp: Time.now.to_i+1)
      assert_equal 1, blk.number

      assert_equal 0, @chain.head.number
      @chain.add_block!(blk)
      assert_equal 1, @chain.head.number
      assert_equal 2, @chain.p1cs.size

      one_third_reward = Economics.block_reward(1) / 3
      tx = Core::Transaction.build_transfer([[blk.transactions[0].hash, 0]], [one_third_reward, one_third_reward, one_third_reward])
      blk = Core::Block.build_candidate(blk.header, SHA3.random.to_s, timestamp: Time.now.to_i+2, transactions: [tx])
      @chain.add_block!(blk)
      assert_equal 0, @chain.genesis.number
      assert_equal 2, @chain.head.number
      # consumed 1 cellbase p1 cell
      # added 3 new p1 cells
      # added 1 cellbase p1 cell
      assert_equal 5, @chain.p1cs.size
    end

    def test_find_block_by_hash
      blk1 = Core::Block.build_candidate(@chain.genesis.header, SHA3.random.to_s, timestamp: Time.now.to_i+1)
      blk2 = Core::Block.build_candidate(blk1.header, SHA3.random.to_s, timestamp: Time.now.to_i+2)
      @chain.add_block!(blk1).add_block!(blk2)

      assert_equal 1, @chain.find(blk1.hash).number
      assert_equal 2, @chain.find(blk2.hash).number
    end
  end
end
