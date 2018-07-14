$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "ckb"

require "minitest/autorun"

CKB.default_log_level = :fatal
