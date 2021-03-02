require_relative "../test_helper"

module Ruby
  module Tags
    class GroupTest < Minitest::Test

      def test_equality
        g1 = Group.new(Void.new("br"))
        g2 = Group.new(Void.new("br"))

        assert_equal g1, g2
      end

      def test_add
        g = Group.new(Void.new("br"))
                 .add(Void.new("div"))
                 .add(Void.new("span"))

        assert_render "<br/><div/><span/>", g
      end
    end
  end
end

