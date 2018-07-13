require 'test_helper'

module CKB
  module DB

    class ForkTest < Minitest::Test
      def setup
        @db = Fork.new(Memory.new)
      end

      def test_is_a_base_db
        assert @db.is_a?(Base)
      end

      def test_fork_count
        assert_equal 0, @db.get_fork_count
      end

      def test_put_genesis
        blk = Core::Block.genesis
        @db.put blk

        assert_equal 1, @db.get_fork_count
        assert_equal 0, @db.get_fork(blk.hash)
      end

      def test_put_blocks_in_the_same_fork
        blk0 = Core::Block.genesis
        @db.put blk0

        blk1 = Core::Block.build(blk0.hash, 1)
        @db.put blk1
        assert_equal 1, @db.get_fork_count
        assert_equal 0, @db.get_fork(blk1.hash)
        assert_nil @db.get_fork(blk0.hash)

        blk2 = Core::Block.build(blk1.hash, 2)
        @db.put blk2
        assert_equal 1, @db.get_fork_count
        assert_equal 0, @db.get_fork(blk2.hash)
        assert_nil @db.get_fork(blk1.hash)
        assert_nil @db.get_fork(blk0.hash)
      end

      def test_put_same_head
        blk0 = Core::Block.genesis
        @db.put blk0

        blka1 = Core::Block.build(blk0.hash, 1)
        @db.put blka1
        assert_equal 1, @db.get_fork_count
        assert_equal 0, @db.get_fork(blka1.hash)
        assert_nil @db.get_fork(blk0.hash)

        assert_raises(ArgumentError) { @db.put blka1 }
      end

      def test_put_blocks_in_different_forks
        blk0 = Core::Block.genesis
        @db.put blk0

        blka1 = Core::Block.build(blk0.hash, 1)
        @db.put blka1
        assert_equal 1, @db.get_fork_count
        assert_equal 0, @db.get_fork(blka1.hash)
        assert_nil @db.get_fork(blk0.hash)

        blkb1 = Core::Block.build(blk0.hash, 1, mix_hash: SHA3.random.to_s)
        @db.put blkb1
        assert_equal 2, @db.get_fork_count
        assert_equal 1, @db.get_fork(blkb1.hash)
        assert_equal 0, @db.get_fork(blka1.hash)
        assert_nil @db.get_fork(blk0.hash)

        blka2 = Core::Block.build(blka1.hash, 2)
        @db.put blka2
        assert_equal 2, @db.get_fork_count
        assert_equal 1, @db.get_fork(blkb1.hash)
        assert_equal 0, @db.get_fork(blka2.hash)
        assert_nil @db.get_fork(blka1.hash)

        blkb2 = Core::Block.build(blkb1.hash, 2, mix_hash: SHA3.random.to_s)
        @db.put blkb2
        assert_equal 2, @db.get_fork_count
        assert_equal 1, @db.get_fork(blkb2.hash)
        assert_equal 0, @db.get_fork(blka2.hash)
        assert_nil @db.get_fork(blkb1.hash)
        assert_nil @db.get_fork(blka1.hash)
      end
    end

  end
end
