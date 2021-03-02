module Ruby
  module Tags
    module Html

      def attr(attributes = {})
        Attribute.new attributes
      end

      def html5(*renderable)
        Group.new Text.new("<!DOCTYPE html>"), NonVoid.new("html", *renderable)
      end

      #############################################
      #               void elements               #
      #############################################
      [
        :area, :base, :br, :col, :command, :embed, :hr, :img, :input,
        :keygen, :link, :meta, :param, :source, :track, :wbr
      ].each do |m|
        define_method(m) do | argument = Attribute.new |
          Void.new m, argument
        end
      end

      #############################################
      #               NonVoid elements            #
      #############################################
      [
        :a, :abbr, :address, :article, :aside, :audio, :b, :bdi, :bdo, :blockquote, :body, :button,
        :canvas, :caption, :cite, :code, :colgroup, :data, :datalist, :dd, :del, :dfn, :div, :dl,
        :dt, :em, :fieldset, :figcaption, :figure, :footer, :form, :h1, :h2, :h3, :h4, :h5, :h6,
        :head, :header, :i, :iframe, :input, :ins, :kbd, :keygen, :label, :legend, :li, :main, :map,
        :mark, :meter, :nav, :noscript, :object, :ol, :optgroup, :option, :output, :p, :pre, :progress,
        :q, :rb, :rp, :rt, :rtc, :ruby, :s, :samp, :script, :section, :select, :small, :span, :strong,
        :style, :sub, :sup, :table, :tbody, :td, :template, :textarea, :tfoot, :th, :thead, :time, :title,
        :tr, :u, :ul, :var, :video
      ].each do |m|
        define_method(m) do | *renderable |
          NonVoid.new m, *renderable
        end
      end
    end
  end
end
