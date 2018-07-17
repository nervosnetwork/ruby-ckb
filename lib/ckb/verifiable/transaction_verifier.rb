module CKB
  module Verifiable
    class TransactionVerifier
      def initialize(target)
        @target = target
      end

      def verify!
        raise InvalidTransaction, "inputs must not be empty" if @target.inputs.empty?
        raise InvalidTransaction, "outputs must not be empty" if @target.outputs.empty?

        @target.outputs.each {|op| op.verify! }
      end
    end
  end
end
