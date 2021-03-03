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

      def test_div_with_attribute_and_text
        assert_render "<div id='123'>some text</div>", div(attr(id: "123"), text("some text"))
      end

      def test_text_last_sibling
        div1 = div(
          div(),
          text("text")
        )

        div2 = div(
          div,
          div,
          text("text")
        )

        assert_render "<div><div></div>text</div>", div1
        assert_render "<div><div></div><div></div>text</div>", div2
      end

      def test_nested
        frag = html5(
                 div(attr(class: "fa fa-up"),
                   div(attr(id: "123"), text("some text"))
                 ),
                 div(
                   br(),
                   text("otherText")
                 )
               )

        exp = "<!DOCTYPE html>" +
               "<html>" +
                 "<div class='fa fa-up'>" +
                   "<div id='123'>some text</div>" +
                 "</div>" +
                 "<div>" +
                   "<br/>otherText" +
                 "</div>" +
               "</html>"

        assert_render exp, frag
      end

      def test_head_block
        frag = html5(attr(lang: "en"),
                 head(
                   meta(attr('http-equiv': "Content-Type", content: "text/html; charset=UTF-8")),
                   title(text("title")),
                   link(attr(href: "xxx.css", rel: "stylesheet"))
                 )
               )

        exp = "<!DOCTYPE html>" +
              "<html lang='en'>" +
                "<head>" +
                  "<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>" +
                  "<title>title</title>" +
                  "<link href='xxx.css' rel='stylesheet'/>"+
                "</head>" +
              "</html>"

        assert_render exp, frag
      end

      def test_js_on_attribute
        frag = div(
          a(attr(href: "xxx", onclick: "alert(\"yay!\")"), text("xxx"))
        )
        assert_render "<div><a href='xxx' onclick='alert(\"yay!\")'>xxx</a></div>", frag
      end

      def test_js_within_script
        s = script(attr(type: "text/javascript"), text(
                "function xxx(){" +
                  "alert('yay!');" +
                "}"
              )
            )

        assert_render "<script type='text/javascript'>function xxx(){alert('yay!');}</script>", s
      end
    end
  end
end
