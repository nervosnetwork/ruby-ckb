module CKB
  module Verifiable
    module Methods
      def verify!
        _verifiers.each {|v| v.verify! }
      end
    end
  end
end
