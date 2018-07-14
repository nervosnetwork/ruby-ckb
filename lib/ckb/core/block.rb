module CKB
  module Core
    class Block
      def self.genesis
        new(header: Header.genesis)
      end

      def self.build(parent_hash, number, difficulty: EMPTY_BYTE, timestamp: Time.now.to_i, nonce: 0, mix_hash: SHA3::NULL, transactions: [])
        header = Header.new(
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

      extend Forwardable
      def_delegators :header, :hash, :hex_hash,
                     :version, :parent_hash, :timestamp,
                     :number, :txroot, :difficulty,
                     :nonce, :mix_hash

      def transactions=(txs)
        validate_transactions!(txs)
        self['transactions'].replace(txs)
        self.header.txroot = ADT::MerkleTree.new(txs).root
      end

      def valid?
        header.valid? && cellbase_valid? && txs_valid?
      end

      def to_s
        "<Block##{number} 0x#{hex_hash[0,8]} v#{version} @#{timestamp}>"
      end

      private

      def validate_cellbase!
        # TODO
      end

      def validate_transactions!(txs)
        # TODO
      end

    end
  end
end
