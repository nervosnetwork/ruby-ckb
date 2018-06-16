require 'test_helper'

module CKB
  module Core
    class BlockTest < Minitest::Test
      def setup
        @genesis = Block.genesis
      end

      def test_genesis_block
        assert_equal 0, @genesis.header.number
        assert_equal SHA3::NULL, @genesis.header.parent_hash
        assert_equal [], @genesis.transactions
      end

      def test_header_delegation
        assert_equal 0, @genesis.number
        assert_equal SHA3::NULL, @genesis.parent_hash
        assert_equal SHA3::NULL, @genesis.txs_root
      end

      def test_build_block
        blk = Block.build(SHA3.random, rand(1..1000))
        assert_equal Header::VERSION, blk.version
        assert_equal SHA3::BYTES, blk.parent_hash.size
        assert_equal [], blk.transactions
        assert blk.number > 0, 'block number should be greater than 0'
      end
    end
  end
end
