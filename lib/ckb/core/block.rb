module CKB
  module Core
    class Block

      class <<self
        def genesis
          new(header: Header.genesis).tap do |blk|
            cellbase = Transaction.build_cellbase 0, SHA3::NULL
            blk.transactions = [cellbase]
          end
        end

        def build_candidate(parent_header, lockhash, timestamp: Time.now.to_i, transactions: [])
          raise ArgumentError, "parent_header (#{parent_header}) must be Header!" unless parent_header.instance_of?(Header)
          raise ArgumentError, "transactions (#{transactions}) must be an array!" unless transactions.instance_of?(Array)

          number = parent_header.number + 1
          cellbase = Transaction.build_cellbase number, lockhash
          transactions.unshift cellbase

          build(parent_header.hash, number, timestamp: timestamp, transactions: transactions)
        end

        def build(parent_hash, number, difficulty: EMPTY_BYTE, timestamp: Time.now.to_i, nonce: 0, mix_hash: SHA3::NULL, transactions: [])
          header = Header.build(
            version: Header::VERSION,
            parent_hash: parent_hash,
            timestamp: timestamp,
            number: number,
            difficulty: difficulty,
            nonce: nonce,
            mix_hash: mix_hash
          )

          new(header: header).tap do |blk|
            blk.transactions = transactions
          end
        end
      end

      extend Forwardable
      def_delegators :header, :hash, :hex_hash,
                     :version, :parent_hash, :timestamp,
                     :number, :txroot, :difficulty,
                     :nonce, :mix_hash

      include Verifiable::Methods

      def cellbase
        transactions[0]
      end

      def transactions=(txs)
        self['transactions'].replace(txs)
        self.header.txroot = ADT::MerkleTree.new(txs).root
      end

      def to_s
        "<Block#%d 0x%s v%d @%d cellbase=0x%s txroot=0x%s txcount=%d>" % [
          number, hex_hash[0,8], version, timestamp,
          cellbase && Util.encode_hex(cellbase.outputs[0].lockhash)[0,8],
          Util.encode_hex(txroot)[0,8], transactions.size-1
        ]
      end

      private

      def _verifiers
        @verifiers = [ Verifiable::BlockVerifier.new(self) ]
      end

    end
  end
end
