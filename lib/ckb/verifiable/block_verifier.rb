module CKB
  module Verifiable
    class BlockVerifier
      def initialize(target)
        @target = target
      end

      def verify!
        #header.valid? && cellbase_valid? && txs_valid?
      end
    end
  end
end
