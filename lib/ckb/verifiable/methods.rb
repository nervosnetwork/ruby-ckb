module CKB
  module Verifiable
    module Methods
      def verify!
        @verifiers.each {|verifier| verifier.verify! }
      end
    end
  end
end
