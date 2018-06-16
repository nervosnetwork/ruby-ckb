module CKB
  EMPTY_BYTE = ''.b.freeze

  UINT64_MAX = 2**64 - 1
  UINT256_MAX = 2**256 - 1

  GENESIS_DIFFICULTY = Util.int_to_big_endian(1984).freeze
end