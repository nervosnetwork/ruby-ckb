module CKB
  module Core
    class Block
      def self.genesis
        new(header: Header.genesis)
      end

      def self.build(
          parent_hash, number, difficulty,
          timestamp: Time.now.to_i,
          nonce: 0, mix_hash: SHA3::NULL,
          transactions: []
        )
        header = Header.new(
          version: Header::VERSION,
          parent_hash: parent_hash.to_s,
          timestamp: timestamp,
          number: number,
          difficulty: difficulty,
          nonce: nonce,
          mix_hash: mix_hash
        )
        new(header: header, transactions: transactions)
      end

      extend Forwardable
      def_delegators :header, :hash,
                     :version, :parent_hash, :timestamp,
                     :number, :txs_root, :difficulty,
                     :nonce, :mix_hash
    end
  end
end
