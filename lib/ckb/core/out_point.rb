module CKB
  module Core
    class OutPoint
      NULL = new(txid: '', index: 0).freeze

      def self.build(*args)
        new(*args)
      end

      def to_key
        txid + Util.int_to_big_endian(index)
      end

      def to_s
        "<OutPoint txid=0x#{Util.encode_hex(txid)[0,8]} index=#{index}>"
      end

    end
  end
end
