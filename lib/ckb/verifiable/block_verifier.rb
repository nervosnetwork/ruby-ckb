module CKB
  module Verifiable
    class BlockVerifier
      def initialize(target)
        @target = target
      end

      def verify!
        @target.header.verify!
        @target.transactions.each {|tx| tx.verify! }
      end
    end
  end
end
