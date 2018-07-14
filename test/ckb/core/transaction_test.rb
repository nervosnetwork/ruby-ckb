require 'test_helper'

module CKB
  module Core
    class TransactionTest < Minitest::Test

      def test_build_cellbase
        tx = Transaction.build_cellbase(1, SHA3.random.to_s)

        assert_equal 0, tx.deps.size
        assert_equal 1, tx.inputs.size
        assert_equal 1, tx.outputs.size

        assert_equal Util.int_to_big_endian(1), tx.inputs[0].unlock
        assert_equal Economics.block_reward(1), tx.outputs[0].capacity
      end

      def test_cellbase_is_different_in_different_blocks
        txs = []
        lockhash = SHA3.random.to_s
        10.times do |i|
          tx = Transaction.build_cellbase(i+1, lockhash)
          assert !txs.include?(tx.hash)
          txs.push tx.hash
        end
      end

    end
  end
end
