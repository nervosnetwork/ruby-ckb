module CKB
    module Core
        class Block
            def self.genesis()
                new(block_header: Header.genesis)
            end

            extend Forwardable
            def_delegators :block_header, :version, :parent_hash,
                :timestamp, :height, :transactions_root, :difficulty,
                :nonce, :mix_hash
        end
    end
end