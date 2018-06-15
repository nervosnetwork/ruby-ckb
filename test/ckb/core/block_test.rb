require 'test_helper'

module CKB
  module Core
    class BlockTest < Minitest::Test
      def setup
        @genesis = Block.genesis
      end

      def test_genesis_block
        assert_equal 0, @genesis.block_header.height
        assert_equal Hash::NULL, @genesis.block_header.parent_hash
        assert_equal [], @genesis.transactions
      end

      def test_header_delegation
        assert_equal 0, @genesis.height
        assert_equal Hash::NULL, @genesis.parent_hash
        assert_equal Hash::NULL, @genesis.transactions_root
      end

      def test_build_block
        blk = Block.build(Hash.random, rand(1..1000), Random.new.bytes(4))
        assert_equal Header::VERSION, blk.version
        assert_equal Hash::LENGTH, blk.parent_hash.size
        assert_equal 4, blk.difficulty.size
        assert_equal [], blk.transactions
        assert blk.height > 0, 'block height should be greater than 0'
      end
    end
  end
end
