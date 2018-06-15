require "test_helper"

module CKB
    module Core
        class HeaderTest < Minitest::Test
            def test_genesis_header
                genesis = Header.genesis

                assert_equal Header::VERSION, genesis.version
                assert_equal Hash::NULL, genesis.parent_hash
                assert (0..1).include?(genesis.timestamp - Time.now.to_i), "abnormal timestamp"
                assert_equal 0, genesis.height
                assert_equal Hash::NULL, genesis.transactions_root
                assert_equal Header::GENESIS_DIFFICULTY, genesis.difficulty
                assert_equal 0, genesis.nonce
                assert_equal Hash::NULL, genesis.mix_hash
            end
        end
    end
end