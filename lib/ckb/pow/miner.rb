module CKB
  module PoW
    class Miner
      def initialize
        @worker = Worker.new
      end

      def mine(parent_header, header)
        adjust_difficulty(header, parent_header.difficulty)

        nonce, mix_hash = @worker.mine(header.difficulty, header.hash)
        header.nonce = nonce
        header.mix_hash = mix_hash

        puts "mined new block! #{header}"
      end

      private

      def adjust_difficulty(header, difficulty)
        # TODO: real difficulty adjustment
        header.difficulty = Util.int_to_big_endian(
          Util.big_endian_to_int(difficulty) +
          Util.big_endian_to_int(GENESIS_DIFFICULTY)
        )
      end
    end
  end
end
