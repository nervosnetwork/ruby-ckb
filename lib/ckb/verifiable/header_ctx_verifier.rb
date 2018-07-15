module CKB
  module Verifiable
    class HeaderCtxVerifier
      def initialize(target, ctx)
        @target = target
        @ctx = ctx
      end

      def verify!
      end
    end
  end
end
