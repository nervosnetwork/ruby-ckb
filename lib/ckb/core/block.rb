module CKB
  module Core
    class Block
      def self.genesis
        new(block_header: Header.genesis)
      end

      def self.build(
          parent_hash, height, difficulty,
          timestamp: Time.now.to_i,
          nonce: 0, mix_hash: SHA3::NULL,
          transactions: []
        )
        header = Header.new(
          version: Header::VERSION,
          parent_hash: parent_hash.to_s,
          timestamp: timestamp,
          height: height,
          difficulty: difficulty,
          nonce: nonce,
          mix_hash: mix_hash
        )
        new(block_header: header, transactions: transactions)
      end

      extend Forwardable
      def_delegators :block_header, :version, :parent_hash,
                     :timestamp, :height, :transactions_root, :difficulty,
                     :nonce, :mix_hash
    end
  end
end
