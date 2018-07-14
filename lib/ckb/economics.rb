module CKB
  module Economics
    extend self

    def total_capacity
      33_600_000_000_000 # Bytes
    end

    def reward_epoch_length
      3_000_000
    end

    def reward_percent
      0.5
    end

    def block_reward(blknum)
      ((total_capacity*reward_percent) / reward_epoch_length) / 2**(blknum / reward_epoch_length)
    end
  end
end
