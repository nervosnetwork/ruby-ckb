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

    end
  end
end
