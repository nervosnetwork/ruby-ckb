module CKB
  # Constants defined in economics can be modified by on-chain governance
  module Economics
    extend self

    TOTAL_CAPACITY = 33_600_000_000_000 # Bytes

    REWARD_EPOCH_LENGTH = 3_000_000

    def block_reward(blknum)
      ((TOTAL_CAPACITY/2) / REWARD_EPOCH_LENGTH) / 2**(blknum / REWARD_EPOCH_LENGTH)
    end
  end
end
