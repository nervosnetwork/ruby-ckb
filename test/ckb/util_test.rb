require 'test_helper'

module CKB
  class UtilTest < Minitest::Test
    include Util

    def test_encode_hex
      assert_equal 'ff00', encode_hex("\xff\x00")
      assert_equal '', encode_hex('')
      assert_equal '616263', encode_hex('abc')
    end

    def test_decode_hex
      assert_equal "\xff\x00".b, decode_hex('ff00')
      assert_equal "\xff\x00".b, decode_hex('ff0')
      assert_equal '', decode_hex('')
      assert_equal 'abc', decode_hex('616263')
      assert_raises(TypeError) { decode_hex('xxxx') }
      assert_raises(TypeError) { decode_hex('\x00\x00') }
    end

    def test_int_to_big_endian
      assert_equal "\x00".b, int_to_big_endian(0)
      assert_equal "\x01".b, int_to_big_endian(1)
      assert_equal "\xff".b * 32, int_to_big_endian(UINT256_MAX)
    end

    def test_big_endian_to_int
      assert_equal 0, big_endian_to_int(EMPTY_BYTE)
      assert_equal 0, big_endian_to_int("\x00".b)
      assert_equal 1, big_endian_to_int("\x01".b)
      assert_equal UINT256_MAX, big_endian_to_int("\xff".b * 32)
    end
  end
end
