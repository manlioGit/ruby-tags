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

      def initialize(name, attribute = Attribute.new, *tags)
        @name, @attribute, @children = name, attribute, tags
      end

      def render
        @children.inject("<#{@name}#{@attribute.render}>") { |m, t| m + t.render } + "</#{@name}>"
      end

      def add(tag)
        @children << tag
        self
      end

      def ==(other)
        @name == other.instance_variable_get(:@name) &&
        @attribute == other.instance_variable_get(:@attribute) &&
        @children == other.instance_variable_get(:@children)
      end
    end

    class Void

      def initialize(name, attribute = Attribute.new)
        @name, @attribute = name, attribute
      end

      def render
        "<#{@name}#{@attribute.render}/>"
      end

      def ==(other)
        @name == other.instance_variable_get(:@name) &&
        @attribute == other.instance_variable_get(:@attribute)
      end
    end
  end
end


