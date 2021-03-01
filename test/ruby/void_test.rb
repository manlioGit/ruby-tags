require_relative "../test_helper"

module Ruby
  module Tags
    class VoidTest < Minitest::Test

      def test_has_self_closing_char
        assert_equal "<br/>", Void.new("br").render
      end

      def test_has_self_closing_char_with_attribute
        assert_equal "<hr aaa='xxx'/>", Void.new("hr", Attribute.new(aaa: "xxx")).render
      end

      def test_equality
        br1 = Void.new("br", Attribute.new(a: "b", c: "d"));
        br2 = Void.new("br", Attribute.new(c: "d", a: "b"));

        assert_equal br1, br2
      end
    end
  end
end
