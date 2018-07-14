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

    def self.double(bytes)
      digest digest(bytes)
    end

    def initialize(bytes)
      bytes = bytes.to_s if bytes.instance_of?(self.class)
      raise TypeError, 'hash must be ASCII-8BIT encoded bytes' unless Util.bytes?(bytes)
      raise TypeError, "hash must be #{BYTES} bytes" if bytes.size != BYTES
      super(bytes)
    end

    def to_hex
      Util.encode_hex(self)
    end
  end
end
