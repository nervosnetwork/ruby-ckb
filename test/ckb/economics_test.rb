require 'test_helper'

module CKB
  module Core
    class EconomicsTest < Minitest::Test
      def test_block_reward
        assert_equal 5_600_000.0, Economics.block_reward(100)
        assert_equal 2_800_000.0, Economics.block_reward(Economics::REWARD_EPOCH_LENGTH+100)
        assert_equal 1_400_000.0, Economics.block_reward(2*Economics::REWARD_EPOCH_LENGTH+100)
      end
    end
  end
end
