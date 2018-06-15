require 'digest/sha3'

module CKB
  module Core
    # SHA3-256 (Keccak not FIPS 202)
    class Hash < String
      BYTES = 32
      BITS = BYTES * 8
      NULL = ("\x00".b * BYTES).freeze

      def self.random
        new(Random.new.bytes(BYTES))
      end

      def self.sha3_256(bytes)
        new(Digest::SHA3.digest(bytes, BITS))
      end

      def initialize(bytes)
        raise ArgumentError, "hash must be #{BYTES} bytes" if bytes.size != BYTES
        raise ArgumentError, "hash must be ASCII-8BIT encoded bytes" if bytes.encoding != Encoding::ASCII_8BIT
        super(bytes)
      end

      def to_hex
        unpack('H*').first
      end

    end
  end
end
