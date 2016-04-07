require 'test_helper'

class NetworkTest < Minitest::Test
  def setup
    @network = Network.new File.read('input.txt')
  end

  def test_scan_data
    assert_equal 9, @network.routes.length
    assert_equal({from: 'A', to: 'B', distance: 5}, @network.routes.first)
    assert_equal({from: 'A', to: 'E', distance: 7}, @network.routes.last)
  end

  def test_neighbors
    assert_equal ['B', 'D', "E"], @network.neighbors('A')
    assert_equal ["C"], @network.neighbors('B')
    assert_equal ["D","E"], @network.neighbors('C')
    assert_equal ["C", "E"], @network.neighbors('D')
    assert_equal ["B"], @network.neighbors('E')
    assert_equal [], @network.neighbors('F')
  end
end
