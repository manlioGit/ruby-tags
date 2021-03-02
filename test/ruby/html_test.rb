require_relative "../test_helper"

module Ruby
  module Tags
    class HtmlTest < Minitest::Test
      include Html

      def test_html5_with_doc_type
        assert_render "<!DOCTYPE html><html></html>", html5
        assert_render "<!DOCTYPE html><html class='xxx'></html>", html5(attr class: "xxx")
        assert_render "<!DOCTYPE html><html class='xxx'><body></body></html>", html5(attr(class: "xxx"), body)
      end

      def test_void_elements
        assert_render "<area/>", area
        assert_render "<area class='xxx'/>", area(attr class: "xxx")
      end

      def test_non_void_elements
        assert_render "<body></body>", body
        assert_render "<body class='xxx'></body>", body(attr(class: "xxx"))
      end
    end
  end
end
