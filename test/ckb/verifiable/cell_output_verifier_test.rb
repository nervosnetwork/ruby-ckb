require 'test_helper'

module CKB
  module Verifiable
    class CellOutputVerifierTest < Minitest::Test

      def test_invalid_capacity
        assert_raises(CellOutputVerifier::InvalidCapacity) { Core::CellOutput.build(0, SHA3.random.to_s).verify! }
      end

      def test_invalid_lockhash
        assert_raises(CellOutputVerifier::InvalidLockhash) { Core::CellOutput.build(100, ' ').verify! }
        assert_raises(CellOutputVerifier::InvalidLockhash) { Core::CellOutput.build(100, ' '*512).verify! }
      end

    end
  end
end
