module Ruby
  module Tags
    class Attribute

      def self.blank?(s)
        s.nil? || s.to_s.strip.empty? || s.empty?
      end

      def initialize(attributes = {})
        @attributes = attributes.to_h { |k,v| [k, v.to_s.split] }
      end

      def add(attribute)
        if attribute.is_a? Hash
          attribute.each do |k, v|
            key = k&.to_sym
            @attributes[key] = [] unless @attributes[key]
            enum(v).each do |e|
              @attributes[key] << e unless @attributes[key].include? e
            end
          end
        end
        add var(attribute) if attribute.is_a? Attribute
        self
      end

      def remove(attribute)
        if attribute.is_a? Hash
          attribute.each do |k, v|
            key = k&.to_sym
            enum(v).each { |e| @attributes[key].delete e } if @attributes[key]
          end
        end
        remove var(attribute) if attribute.is_a? Attribute
        @attributes.delete attribute if [String, Symbol].any? { |x| attribute.is_a? x }
        self
      end

      def render
        @attributes.reject{ |k,v| [k,v].any? { |x| Attribute.blank? x } }
                   .reduce(@attributes.empty? && "" || " ") { |m, (k, a)| "#{m}#{k}='#{sanitize(a)}' " }
                   .delete_suffix(" ")
      end

      def ==(other)
        @attributes.keys.sort == var(other).keys.sort &&
        @attributes.values.flatten.sort == var(other).values.flatten.sort
      end

      private

      def enum(v)
        if v
          v.is_a?(Enumerable) ? v : v.to_s.split
        else
          []
        end
      end

      def var(other)
        other.instance_variable_get(:@attributes)
      end

      def sanitize(s)
        s.join(" ").gsub(/'/,"&#x27;").strip
      end
    end
  end
end
