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

  def test_neighbors
    assert_equal ['B', 'D', 'E'], @network.neighbors('A')
    assert_equal ["C"], @network.neighbors('B')
    assert_equal ["D","E"], @network.neighbors('C')
    assert_equal ["C", "E"], @network.neighbors('D')
    assert_equal ["B"], @network.neighbors('E')
    assert_equal [], @network.neighbors('F')
  end

  def test_find_route
    assert_equal(Route.new('A', 'B', 5), @network.find_route('A', 'B'))
    assert_equal(Route.new('A', 'E', 7), @network.find_route('A', 'E'))
  end

  def test_total_distance
    assert_equal 9, @network.total_distance('A', 'B', 'C')
    assert_equal 5, @network.total_distance('A', 'D')
    assert_equal 13, @network.total_distance('A', 'D', 'C')
    assert_equal 22, @network.total_distance('A', 'E', 'B', 'C', 'D')
    assert_equal Float::INFINITY, @network.total_distance('A', 'E', 'D')
  end
end
