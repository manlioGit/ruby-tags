require_relative "../test_helper"

module Ruby
  module Tags
    class AttributeTest < Minitest::Test
      include ::Ruby::Tags::Html

      def test_render
        assert_render " id='123' class='fa fa-up'", attr(id: "123", class: "fa fa-up")
        assert_render " id='123' class='fa fa-up'", attr(id: 123, class: "fa fa-up")
      end

      def test_render_normalize_spaces
        assert_render " id='123' class='fa fa-up'", attr(id: "  123 ", class: " fa      fa-up ")
      end

      def test_dont_render_null_or_empty_keys
        a = attr id: 123,
                 "  ": nil,
                 class: "fa fa-up",
                 nil => "xx",
                 x: "",
                 " ": "xx",
                 " " => "ccc"

        assert_render " id='123' class='fa fa-up' x=''", a
      end

      def test_add_attribute_using_hash
        a = attr(class: "some", xxx:"fa fa-up")
              .add(class: "fa fa-up", xxx: "show")
              .add(class: "fa", xxx: "show")
              .add(nil)
              .add(xxx: "hide")
              .add(xxx: nil)
              .add(nil => nil)
              .add(yyy: "show-some")

        assert_render " class='some fa fa-up' xxx='fa fa-up show hide' yyy='show-some'", a
      end

      def test_add_attribute_using_attribute
        a = attr(class: "some", xxx:"fa fa-up")
              .add(attr class: "fa fa-up")
              .add(attr nil)
              .add(attr xxx: "hide")
              .add(attr xxx: "show", yyy: "show-some")

        assert_render " class='some fa fa-up' xxx='fa fa-up hide show' yyy='show-some'", a
      end

      def test_remove_attribute_using_hash
        a = attr(class: ".some fa fa-up", xxx: "fa fa-up")
              .remove(class: "fa-up")
              .remove(nil)
              .remove("class" => "notExistent")
              .remove("xxx" => "fa")
              .remove(xxx: nil)
              .remove(nil => nil)
              .remove(xxx: "fa-up")
              .remove("xxx" => "fa-up")
              .remove(notExistentKey: "show-some")

        assert_render " class='.some fa' xxx=''", a
        assert_render " class='.some'", attr(class: ".some fa fa-up").remove(class:"fa fa-up")
        assert_render " class='.some fa fa-up'", attr(class: ".some fa fa-up").remove(nil => nil)
      end

      def test_remove_using_attribute
        a = attr(class: ".some fa fa-up", xxx: "fa fa-up")
              .remove(attr class: "fa-up")
              .remove(attr class: "notExistent")
              .remove(attr xxx: "fa")
              .remove(attr nil)
              .remove(attr xxx: "fa-up")
              .remove(attr xxx: "fa-up")
              .remove(attr notExistentKey: "show-some")

        assert_render " class='.some fa' xxx=''", a
      end

      def test_complete_removal
        a = attr(class: ".some fa fa-up", xxx: "fa fa-up")
             .remove("class")
             .remove(:class)
             .remove("xxx")
             .remove(:xxx)

        assert_render "", a
      end

      def test_equality
        a = attr class: ".some fa fa-up", xxx: "fa fa-up"
        b = attr xxx: "fa fa-up", class: ".some fa fa-up"
        c = attr.add(xxx: "fa").add(xxx: "fa-up").add("class" => "fa")
                .add(class: ".some").add("class" => "fa-up")

        assert_equal a,b
        assert_equal b,c
        assert_equal a,c
        assert !(a == b.add(c: 12))
      end

      def test_sanitize
        assert_render " value='1&#x27;000'", attr(value: "1'000")
      end

      def test_empty_attribute
        assert_render "", attr
      end
    end
  end
end
