module CKB
  module Util
    extend self

    def encode_hex(b)
      raise TypeError, "Value must be an instance of String" unless b.is_a?(String)
      b.unpack("H*").first
    end

    def decode_hex(s)
      raise TypeError, "Value must be an instance of string" unless s.is_a?(String)
      raise TypeError, 'Non-hexadecimal digit found' unless s =~ /\A[0-9a-fA-F]*\z/
      [s].pack("H*")
    end

    def big_endian_to_int(v)
      v.unpack('H*').first.to_i(16)
    end

    def int_to_big_endian(v)
      hex = v.to_s(16)
      hex = "0#{hex}" if hex.size.odd?
      [hex].pack('H*')
    end

    def bytes?(s)
      s && s.instance_of?(String) && s.encoding == Encoding::ASCII_8BIT
    end
  end
end