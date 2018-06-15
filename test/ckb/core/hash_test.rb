require 'test_helper'

module CKB
  module Core
    class HashTest < Minitest::Test
      def test_random_hash
        assert_equal 32, Hash.random.size
      end

      def test_invalid_hash
        assert_raises(ArgumentError) { Hash.new('') }
        assert_raises(ArgumentError) { Hash.new('\x00') }
        assert_raises(ArgumentError) { Hash.new('\x00'*31) }
        assert_raises(ArgumentError) { Hash.new('\x00'*33) }
      end

      def test_hash_empty_string
        assert_equal "\xC5\xD2F\x01\x86\xF7#<\x92~}\xB2\xDC\xC7\x03\xC0\xE5\x00\xB6S\xCA\x82';{\xFA\xD8\x04]\x85\xA4p".b, Hash.sha3_256('')
        assert_equal 'c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470', Hash.sha3_256('').to_hex
      end
    end
  end
end
