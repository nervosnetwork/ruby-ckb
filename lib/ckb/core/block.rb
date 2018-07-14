module CKB
  module Core
    class Block
      def self.genesis
        new(header: Header.genesis)
      end

      def self.build(
          parent_hash, number,
          difficulty: EMPTY_BYTE,
          timestamp: Time.now.to_i,
          nonce: 0, mix_hash: SHA3::NULL,
          transactions: []
        )
        header = Header.new(
          version: Header::VERSION,
          parent_hash: parent_hash,
          timestamp: timestamp,
          number: number,
          difficulty: difficulty,
          nonce: nonce,
          mix_hash: mix_hash
        )
        new(header: header, transactions: transactions)
      end

      extend Forwardable
      def_delegators :header, :hash, :hex_hash,
                     :version, :parent_hash, :timestamp,
                     :number, :txs_root, :difficulty,
                     :nonce, :mix_hash

      def transactions=(txs)
        self['transactions'].replace(txs)
      end

      def valid?
        header.valid? && cellbase_valid? && txs_valid?
      end

      def to_s
        "<Block##{number} 0x#{hex_hash[0,8]} v#{version} @#{timestamp}>"
      end

      private

      def cellbase_valid?
      end

      def txs_valid?
      end

    end
  end
end
