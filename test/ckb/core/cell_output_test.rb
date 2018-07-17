require 'test_helper'

module CKB
  module Core
    class CellOutputTest < Minitest::Test

      def test_build_cell_output
        output = CellOutput.build(100, SHA3.random.to_s)
        assert_equal 32, output.lockhash.size
      end

    end
  end
end
