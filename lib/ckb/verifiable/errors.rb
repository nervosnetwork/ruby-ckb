module CKB
  module Verifiable
    class InvalidHeader < StandardError; end
    class InvalidPoW < InvalidHeader; end

    class InvalidTransaction < StandardError; end
    class InvalidCellbase < StandardError; end
    class InvalidCellInput < StandardError; end
    class InvalidCellOutput < StandardError; end
    class InvalidOutpoint < StandardError; end
    class UnbalancedCapacity < StandardError; end
  end
end
