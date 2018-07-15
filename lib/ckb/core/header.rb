require 'digest/sha3'

module CKB
  module Core
    class Header
      include Verifiable::Methods

      VERSION = 0x1

      class <<self
        def genesis
          build(
            version: VERSION,
            parent_hash: SHA3::NULL,
            timestamp: Time.now.to_i,
            number: 0,
            txroot: ADT::MerkleTree::EMPTY_ROOT,
            difficulty: GENESIS_DIFFICULTY,
            nonce: 0,
            mix_hash: SHA3::NULL
          )
        end

        def build(*args)
          new(*args)
        end
      end

      def hash
        SHA3.digest(to_proto).to_s
      end

      def hex_hash
        SHA3.digest(to_proto).to_hex
      end

      def to_s
        "<Header##{number} 0x#{hex_hash[0,8]} v#{version} @#{timestamp}>"
      end

      private

      def _verifiers
        @verifiers ||= [ Verifiable::HeaderVerifier.new(self) ]
      end

    end
  end
end
