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

  def test_from
    assert_equal 'A', @path.from
  end

  def test_to
    assert_equal 'C', @path.to
  end

  def test_wrong_path
    assert_raises ArgumentError do
      @path << Route.new('A', 'B', 2)
    end
  end
end
