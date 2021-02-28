module Ruby
  module Tags
    module Html
      def attr(attributes = {})
        Attribute.new attributes
      end
    end
  end
end
