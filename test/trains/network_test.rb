require 'test_helper'

class NetworkTest < Minitest::Test
  def setup
    @network = Network.new File.read('input.txt')
  end

  def test_scan_data
    assert_equal 9, @network.routes.length
    assert_equal(Route.new('A', 'B', 5), @network.routes.first)
    assert_equal(Route.new('A', 'E', 7), @network.routes.last)
  end

  def test_neighbor_routes
    assert_equal [Route.new('A', 'B', 5), Route.new('A', 'D', 5), Route.new('A', 'E', 7)], @network.neighbor_routes('A')
  end

  def test_find_route
    assert_equal(Route.new('A', 'B', 5), @network.find_route('A', 'B'))
    assert_equal(Route.new('A', 'E', 7), @network.find_route('A', 'E'))
  end

  def test_distance
    assert_equal 9, @network.distance('A', 'B', 'C')
    assert_equal 5, @network.distance('A', 'D')
    assert_equal 13, @network.distance('A', 'D', 'C')
    assert_equal 22, @network.distance('A', 'E', 'B', 'C', 'D')
    assert_raises Trains::RouteNotFound do
      @network.distance('A', 'E', 'D')
    end
  end

  def test_max_stops
    paths = @network.find_max_stops('C', 'C', 3)
    assert_equal 2, paths.length
  end

  def test_exact_stops
    paths = @network.find_exact_stops('A', 'C', 4)
    assert_equal 3, paths.length
  end

  def test_find_max_distance
    paths = @network.find_max_distance('C', 'C', 29)
    assert_equal 7, paths.length
  end

  def test_shortest_route_one
    assert_equal 9, @network.shortest_path('A', 'C')
  end

  def test_shortest_route_two
    assert_equal 9, @network.shortest_path('B', 'B')
  end
end
