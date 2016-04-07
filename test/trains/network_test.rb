require 'test_helper'

class NetworkTest < Minitest::Test
  def setup
    @network = Network.new('AB1, AC2')
  end

  def test_scan_data
    assert_equal 2, @network.routes.length
    assert_equal({from: 'A', to: 'B', distance: 1}, @network.routes.first)
  end
end
