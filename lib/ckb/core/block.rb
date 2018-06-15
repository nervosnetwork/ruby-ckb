module CKB
    module Core
        class Block
            def self.genesis()
                new(block_header: Header.genesis)
            end
        end
    end
end