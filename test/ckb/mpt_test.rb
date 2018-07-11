# -*- encoding : ascii-8bit -*-

require 'test_helper'

module CKB

  class MPTTest < Minitest::Test
    def setup
      @mpt = MPT.new DB::Memory.new
    end

    def test_to_hash
      data = [
        {k: '2e0de3fc10a88911ff857126db1a5f0da6f25173',
         v: 'f8448001a056e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421a0a45fdf1695a9bb0ff5595dd47acbeaac4c8473c9646ac92551b3fe40bc433103',
         keys: [".\r\xE3\xFC\x10\xA8\x89\x11\xFF\x85q&\xDB\x1A_\r\xA6\xF2Qs"]
        },
        {k: '64306ec3f51a26dcf19f5da0c043040f54f4eca5',
         v: 'f8448001a056e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421a01e34bed912737e84fc3bd36d2b35bdf5ef08ec4dda4a38d93e6c545a12542b4e',
         keys: [".\r\xe3\xfc\x10\xa8\x89\x11\xff\x85q&\xdb\x1a_\r\xa6\xf2Qs", "d0n\xc3\xf5\x1a&\xdc\xf1\x9f]\xa0\xc0C\x04\x0fT\xf4\xec\xa5"]
        }
      ]

      data.each do |h|
        @mpt[Util.decode_hex(h[:k])] = Util.decode_hex(h[:v])
        assert_equal h[:keys], @mpt.to_h.keys
        assert_equal h[:keys].size, @mpt.size
      end
    end

  end

end