require_relative "../test_helper"

module Ruby
  module Tags
    class TextTest < Minitest::Test

      def test_equality
        assert_equal Text.new("aaa"), Text.new("aaa")
      end

      def test_render
        assert_equal "aaa", Text.new("aaa").render
      end
    end
  end
end
