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
        assert_equal 1, @genesis.transactions.size
      end

      def test_header_delegation
        assert_equal 0, @genesis.number
        assert_equal SHA3::NULL, @genesis.parent_hash
        refute_equal ADT::MerkleTree::EMPTY_ROOT, @genesis.txroot
      end

      def test_build_block
        blk = Block.build(SHA3.random.to_s, rand(1..1000))
        assert_equal Header::VERSION, blk.version
        assert_equal SHA3::BYTES, blk.parent_hash.size
        assert_equal [], blk.transactions
        assert blk.number > 0, 'block number should be greater than 0'
      end

      def test_build_candidate
        lockhash = SHA3.random.to_s
        blk = Block.build_candidate(@genesis.header, lockhash)
        assert_equal Header::VERSION, blk.version
        assert_equal @genesis.hash, blk.parent_hash
        assert_equal 1, blk.number
        assert_equal 1, blk.transactions.size
        assert_equal 1, Util.big_endian_to_int(blk.transactions[0].inputs[0].unlock)
        assert_equal lockhash, blk.transactions[0].outputs[0].lockhash
      end

      def test_set_transactions
        tx1 = Transaction.build_cellbase(1, SHA3.random.to_s)
        blk = Block.build(SHA3.random.to_s, 1, transactions: [tx1])
        assert_equal [tx1], blk.transactions
        assert_equal ADT::MerkleTree.new([tx1]).root, blk.txroot

        input = CellInput.build(SHA3.random.to_s, 0, SHA3.random.to_s)
        output = CellOutput.build(100, SHA3.random.to_s)
        tx2 = Transaction.build(inputs: [input], outputs: [output])
        blk.transactions = [tx1, tx2]
        assert_equal [tx1, tx2], blk.transactions
        assert_equal ADT::MerkleTree.new([tx1, tx2]).root, blk.txroot
      end
    end
  end
end
