require 'test_helper'

module CKB
  module DB

    class ChainTest < Minitest::Test
      def setup
        @db = Chain.new(Memory.new)
      end

      def test_is_a_base_db
        assert @db.is_a?(Base)
      end

      def test_put_block
        blk = Core::Block.genesis
        @db.put blk

        assert_equal blk, @db.get("blk:#{blk.hash}")
        assert_equal blk, @db.get_block(blk.hash)
        assert_equal blk.header, @db.get_header(blk.hash)
      end

      def test_put_header
        blk = Core::Block.genesis
        @db.put blk.header

        assert_nil @db.get_block(blk.hash)
        assert_equal blk.header, @db.get_header(blk.hash)
      end

      def test_put_transaction
        #TODO
      end

    end

  end
end
