require 'test_helper'

module CKB
  module Core
    class CellInputTest < Minitest::Test

      def test_build_cellbase_input
        input = CellInput.build_cellbase_input(100)
        assert_equal OutPoint::NULL, input.previous_output
        assert_equal 100, Util.big_endian_to_int(input.unlock)
      end

    end
  end
end
