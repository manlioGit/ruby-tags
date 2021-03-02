require_relative "../test_helper"

module Ruby
  module Tags
    class NonVoidTest < Minitest::Test

      def test_simple_tag
        assert_render "<html></html>", NonVoid.new("html")
      end

      def test_simple_tag_with_attribute
        assert_render "<div id='123'></div>", NonVoid.new("div", Attribute.new(id: 123))
        assert_render "<div id='123'></div>", NonVoid.new("div", Attribute.new(id: "123"))
      end

      def test_simple_tag_with_text
        assert_render "<div>text</div>", NonVoid.new("div", Text.new("text"))
        assert_render "<div id='123'>text</div>", NonVoid.new("div", Attribute.new(id: 123), Text.new("text"))
      end

      def test_nested_tag
        assert_render "<div><span></span></div>", NonVoid.new("div", NonVoid.new("span"))
        assert_render "<div id='123'><span></span></div>", NonVoid.new("div", Attribute.new(id: "123"), NonVoid.new("span"))
        assert_render "<div><span id='123'></span></div>", NonVoid.new("div", NonVoid.new("span", Attribute.new(id: "123")))
      end

      def test_nested_tag_with_text
        assert_render "<div><span>text</span></div>", NonVoid.new("div", NonVoid.new("span", Text.new("text")))
      end

      def test_text_and_nested_tag
        tag = NonVoid.new("div", Text.new("text"), NonVoid.new("span"))

        assert_render "<div>text<span></span></div>", tag
      end

      def test_nested_tag_and_text
        tag = NonVoid.new("div", NonVoid.new("span"), Text.new("text"))

        assert_render "<div><span></span>text</div>", tag
      end

      def test_sibling_tags
        tag = Group.new(Text.new("<!DOCTYPE html>"), NonVoid.new("html"))

        assert_render "<!DOCTYPE html><html></html>", tag
      end

      def test_equality
        div1 = NonVoid.new("div", Attribute.new(a: "b", c: "d"))
        div2 = NonVoid.new("div", Attribute.new(c: "d", a: "b"))

        assert_equal div1, div2
      end

      def test_add
        nonVoid = NonVoid.new("div")
          .add(NonVoid.new("span"))
          .add(NonVoid.new("span"))
          .add(NonVoid.new("span"))
          .add(NonVoid.new("div"))


        assert_render "<div><span></span><span></span><span></span><div></div></div>", nonVoid
      end
    end
  end
end
