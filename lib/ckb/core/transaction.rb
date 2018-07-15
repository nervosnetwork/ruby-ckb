require 'digest/sha3'

module CKB
  module Core
    class Transaction
      def self.build_cellbase(blknum, lockhash)
        input = CellInput.build_cellbase_input(blknum)
        output = CellOutput.build(Economics.block_reward(blknum), lockhash)
        build(inputs: [input], outputs: [output])
      end

      def self.build(*args)
        new(*args).tap do |tx|
          tx.validate!
        end
      end

      def validate!
        raise ArgumentError, "inputs must be non-empty!" if inputs.empty?
        raise ArgumentError, "outputs must be non-empty!" if outputs.empty?
      end

      def hash
        SHA3.digest(to_proto).to_s
      end

      def hex_hash
        SHA3.digest(to_proto).to_hex
      end

      def to_s
        "<Tx 0x#{hex_hash[0,8]}>"
      end
    end
  end
end
