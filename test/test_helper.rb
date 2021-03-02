$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require 'minitest/reporters'
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)
require 'minitest/autorun'

require "ruby/ruby-tags"

def assert_render(expected, renderable)
  assert_equal expected, renderable.render
end
