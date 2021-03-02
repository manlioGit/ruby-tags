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

      def ==(other)
        @tags == other.instance_variable_get(:@tags)
      end
    end

    class Text

      def initialize(text)
        @text = text
      end

      def render
        @text
      end

      def ==(other)
        @text == other.instance_variable_get(:@text)
      end
    end

    class NonVoid

      def initialize(name, *renders)
        @name = name
        @attribute = renders.find { |r| r.is_a? Attribute } || Attribute.new
        @children = renders.reject { |r| r.is_a? Attribute }
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


