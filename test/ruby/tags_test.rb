require "test_helper"

class Ruby::TagsTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Ruby::Tags::VERSION
  end
end
