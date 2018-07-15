module CKB
  module Verifiable
    class TransactionVerifier
      class MissingInput < StandardError; end
      class MissingOutput < StandardError; end

      def initialize(target)
        @target = target
      end

      def verify!
        raise MissingInputError, "inputs must be non-empty!" if @target.inputs.empty?
        raise MissingOutputError, "outputs must be non-empty!" if @target.outputs.empty?
      end
    end
  end
end
