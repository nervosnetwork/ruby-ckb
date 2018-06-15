module CKB
    module Core
        class Header
            VERSION = 0x1
            GENESIS_DIFFICULTY = "\x10\x00\x00\x00"

            def self.genesis()
                new(
                    version: VERSION,
                    parent_hash: Hash::NULL,
                    timestamp: Time.now.to_i,
                    height: 0,
                    transactions_root: Hash::NULL,
                    difficulty: GENESIS_DIFFICULTY,
                    nonce: 0,
                    mix_hash: Hash::NULL
                )
            end
        end
    end
end