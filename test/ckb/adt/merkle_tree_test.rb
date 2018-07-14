# -*- encoding : ascii-8bit -*-

require 'test_helper'

module CKB
  module ADT

    class MerkleTreeTest < Minitest::Test
      def test_empty_tree
        assert_equal MerkleTree::EMPTY_ROOT,  MerkleTree.new([]).root
      end

      def test_single_node_tree
        assert_equal SHA3.double('abc'), MerkleTree.new(['abc']).root
        assert_equal SHA3.double('123'), MerkleTree.new(['123']).root
      end

      def test_tree_with_odd_leaves
        assert_equal MerkleTree.new(%w(a b c c)).root, MerkleTree.new(%w(a b c)).root
        assert_equal MerkleTree.new(%w(a b c d e e)).root, MerkleTree.new(%w(a b c d e)).root
      end

      def test_tree_with_even_leaves
        ab_root = MerkleTree.new(%w(a b)).root
        cd_root = MerkleTree.new(%w(c d)).root
        abcd_root = MerkleTree.new(%w(a b c d)).root
        assert_equal SHA3.double(ab_root+cd_root), abcd_root

        efgh_root = MerkleTree.new(%w(e f g h)).root
        assert_equal SHA3.double(abcd_root+efgh_root), MerkleTree.new('a'..'h').root
      end
    end

  end
end
