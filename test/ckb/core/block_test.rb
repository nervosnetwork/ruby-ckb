require "test_helper"

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
        end
    end
end