module CKB
  module Verifiable
    class BlockCtxVerifier
      def initialize(blk, ctx)
        @blk = blk
        @ctx = ctx
      end

      def verify!
        HeaderCtxVerifier.new(@blk.header, @ctx).verify!
      end

      def parent
        @parent ||= @ctx.get_parent(@blk)
      end
    end
  end
end
