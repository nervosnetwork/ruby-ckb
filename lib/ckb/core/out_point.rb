module CKB
  module Core
    class OutPoint
      NULL = new(hash: '', index: 0).freeze

      def self.build(*args)
        new(*args).tap do |op|
          op.validate!
        end
      end

      def validate!
      end
    end
  end
end
