require "test_helper"

class CKBTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::CKB::VERSION
  end
end
