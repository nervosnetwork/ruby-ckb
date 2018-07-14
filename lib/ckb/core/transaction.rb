require 'digest/sha3'

module CKB
  module Core
    class Transaction
      def self.build_cellbase(blknum, lockhash)
        input = CellInput.build_cellbase_input(blknum)
        output = CellOutput.build(Economics.block_reward(blknum), lockhash)
        new(inputs: [input], outputs: [output])
      end

      def hash
        SHA3.digest(self.class.encode(self))
      end

      def hex_hash
        hash.to_hex
      end

      def to_s
        "<Tx 0x#{hex_hash[0,8]}>"
      end
    end
  end
end
