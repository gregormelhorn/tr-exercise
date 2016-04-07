require 'test_helper'

class PathTest < Minitest::Test
  def setup
    @path = Path.new()
    @path << Route.new('A', 'B', 5)
    @path << Route.new('B', 'C', 4)
  end

  def test_distance
    assert_equal 9, @path.distance
  end

  def test_add_route
    @path << Route.new('C', 'D', 2)
    assert_equal 11, @path.distance
  end
end
