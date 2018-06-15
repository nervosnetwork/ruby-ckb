require 'test_helper'

module CKB
  module Core
    class HashTest < Minitest::Test
      def test_random_hash
        assert_equal 32, Hash.random.size
      end
    end
  end
end
