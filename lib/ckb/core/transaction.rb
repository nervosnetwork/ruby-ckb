require 'digest/sha3'

module CKB
  module Core
    class Transaction

      class <<self
        def build_cellbase(blknum, lockhash)
          input = CellInput.build_cellbase_input(blknum)
          output = CellOutput.build(Economics.block_reward(blknum), lockhash)
          build(inputs: [input], outputs: [output])
        end

        def build_transfer(outpoints, capacities)
          inputs = outpoints.map {|txid, index| CellInput.build(txid, index, '') }
          outputs = capacities.map {|capacity| CellOutput.build(capacity, SHA3.random.to_s) }
          build(inputs: inputs, outputs: outputs)
        end

        def build(*args)
          new(*args)
        end
      end

      include Verifiable::Methods

      def hash
        SHA3.digest(to_proto).to_s
      end

      def hex_hash
        SHA3.digest(to_proto).to_hex
      end

      def to_s
        "<Tx 0x#{hex_hash[0,8]}>"
      end

      private

      def _verifiers
        @_verifiers ||= [ Verifiable::TransactionVerifier.new(self) ]
      end

    end
  end
end
