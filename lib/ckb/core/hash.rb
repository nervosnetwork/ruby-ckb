module CKB
    module Core
        # SHA3
        class Hash
            LENGTH = 32
            NULL = "\x00" * LENGTH

            def self.random()
                Random.new.bytes(LENGTH)
            end
        end
    end
end