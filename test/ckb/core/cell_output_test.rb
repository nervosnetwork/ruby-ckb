require 'test_helper'

module CKB
  module Core
    class CellOutputTest < Minitest::Test

      def test_build_cell_output
        output = CellOutput.build(100, SHA3.random.to_s)
        assert_equal 32, output.lockhash.size
      end

      def test_invalid_capacity
        assert_raises(ArgumentError) { CellOutput.build(0, SHA3.random.to_s) }
      end

      def test_invalid_lockhash
        assert_raises(ArgumentError) { CellOutput.build(100, ' ') }
        assert_raises(ArgumentError) { CellOutput.build(100, ' '*512) }
      end

    end
  end
end
