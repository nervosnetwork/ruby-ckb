require 'digest/sha3'

module CKB
  module Core
    class Header
      VERSION = 0x1

      def self.genesis
        new(
          version: VERSION,
          parent_hash: SHA3::NULL,
          timestamp: Time.now.to_i,
          number: 0,
          txs_root: SHA3::NULL,
          difficulty: GENESIS_DIFFICULTY,
          nonce: 0,
          mix_hash: SHA3::NULL
        )
      end

      def hash
        SHA3.digest(self.class.encode(self))
      end

      def hex_hash
        hash.to_hex
      end
    end
  end
end
