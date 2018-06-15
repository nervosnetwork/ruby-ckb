require 'test_helper'

module CKB
  module Core
    class HeaderTest < Minitest::Test
      def setup
        @genesis = Header.genesis
      end

      def test_genesis_header
        assert_equal Header::VERSION, @genesis.version
        assert_equal SHA3::NULL, @genesis.parent_hash
        assert (0..1).cover?(@genesis.timestamp - Time.now.to_i), 'abnormal timestamp'
        assert_equal 0, @genesis.number
        assert_equal SHA3::NULL, @genesis.txs_root
        assert_equal Header::GENESIS_DIFFICULTY, @genesis.difficulty
        assert_equal 0, @genesis.nonce
        assert_equal SHA3::NULL, @genesis.mix_hash
      end

      def test_header_hash
        assert_equal 32, @genesis.hash.size
        assert_equal 64, @genesis.hex_hash.size
      end
    end
  end
end
