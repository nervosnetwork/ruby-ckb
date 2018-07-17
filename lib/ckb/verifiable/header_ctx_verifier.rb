module CKB
  module Verifiable
    class HeaderCtxVerifier
      def initialize(target, ctx)
        raise ArgumentError, "target must be Header" unless target.instance_of?(Core::Header)
        @target = target
        @ctx = ctx
      end

      def verify!
        raise InvalidHeader, "header parent 0x#{Util.encode(@target.parent_hash)[0,8]} doesn't exist" if parent.nil?
        raise InvalidHeader, "timestamp must be larger than its parent" if @target.timestamp <= parent.timestamp
        raise InvalidHeader, "block number must advance by 1" if @target.number != parent.number+1
        # TODO: difficulty verification / InvalidPoW
        # TODO: pow verification / InvalidPoW
      end

      def parent
        @parent ||= @ctx.get_parent_header(@target)
      end
    end
  end
end
