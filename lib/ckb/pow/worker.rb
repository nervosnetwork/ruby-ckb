module CKB
  module PoW
    class Worker

      def mine(difficulty, hash)
        # TODO: real mining
        sleep(1) # mock hashing
        nonce = Random.new.rand(UINT64_MAX)
        mix_hash = SHA3.random.to_s
        return nonce, mix_hash
      end

    end
  end
end