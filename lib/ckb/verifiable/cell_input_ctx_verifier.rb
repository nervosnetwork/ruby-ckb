module CKB
  module Verifiable
    class CellInputCtxVerifier
      def initialize(target, ctx)
        @target = target
        @ctx = ctx
      end

      def verify!
        raise InvalidCellInput, "input refers to non-exist output: #{@target.previous_output}" unless @ctx.p1cs.has_key?(@target.previous_output.to_key)
        # TODO: verify input unlock script
      end
    end
  end
end
