require 'test_helper'

module CKB
  module Core
    class EconomicsTest < Minitest::Test
      def test_block_reward
        assert_equal 5600000.0, Economics.block_reward(100)
      end
    end
  end
end
