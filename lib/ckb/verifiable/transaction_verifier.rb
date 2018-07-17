module CKB
  module Verifiable
    class TransactionVerifier
      class MissingInput < StandardError; end
      class MissingOutput < StandardError; end
      class InvalidOutput < StandardError; end

      def initialize(target)
        @target = target
      end

      def verify!
        raise MissingInputError, "inputs must not be empty" if @target.inputs.empty?
        raise MissingOutputError, "outputs must not be empty" if @target.outputs.empty?

        @target.outputs.each {|op| op.verify! }
      end
    end
  end
end
