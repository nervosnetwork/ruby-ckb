module CKB
  module Verifiable
    module Methods
      def verify!
        _verifiers.each {|v| v.verify! }
      end

      def serialize!
        verify!
        to_proto
      end
    end
  end
end
