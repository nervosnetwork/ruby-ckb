require 'digest/sha3' # Keccak not FIPS 202

module CKB
  class SHA3 < String
    BYTES = 32 # Default to SHA3-256
    BITS = BYTES * 8
    NULL = ("\x00".b * BYTES).freeze

    def self.random
      new(Random.new.bytes(BYTES))
    end

    def self.digest(bytes)
      new(Digest::SHA3.digest(bytes, BITS))
    end

    def initialize(bytes)
      raise ArgumentError, "hash must be #{BYTES} bytes" if bytes.size != BYTES
      raise ArgumentError, 'hash must be ASCII-8BIT encoded bytes' if bytes.encoding != Encoding::ASCII_8BIT
      super(bytes)
    end

    def to_hex
      unpack('H*').first
    end
  end
end
