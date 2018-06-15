require "test_helper"

module CKB
    module Core
        class BlockTest < Minitest::Test
            def test_genesis_block
                genesis = Block.genesis

                assert_equal 0, genesis.block_header.height
                assert_equal Hash::NULL, genesis.block_header.parent_hash
                assert_equal [], genesis.transactions
            end
        end
    end
end