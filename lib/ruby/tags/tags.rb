module Ruby
  module Tags

    class Group

      def initialize(*tags)
        @tags = tags
      end

      def render
        @tags.map(&:render).join
      end

      def add(tag)
        @tags << tag
        self
      end
    end

    class Text

      def initialize(text)
        @text = text
      end

      def render
        @text
      end
    end

    class NonVoid

      def initialize(name, attribute = nil, *tags)
        @name = name, @attribute = attribute, @children = tags
      end

      def render
        @children.inject("<#{@name} #{@attribute.render}>") { |m, t| m + t.render } + "</#{@name}>"
      end

      def add(tag)
        @children << tag
      end
    end

    class Void
      def initialize(name, attribute = nil)
        @name = name, @attribute = attribute
      end

      def render
        "<#{@name} #{@attribute.render}/>"
      end
    end
  end
end


