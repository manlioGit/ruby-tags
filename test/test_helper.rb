require 'minitest/autorun'
require 'ruby-tags'

def assert_render(expected, renderable)
  assert_equal expected, renderable.render
end
