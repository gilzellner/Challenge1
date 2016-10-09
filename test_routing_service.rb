require './routing_service.rb'
require 'test/unit'
require './utils.rb'

class WeatherTest < Test::Unit::TestCase
  def test_get_google_data_for_travel1
    assert_equal(1, get_nested_hash_value(get_google_data_for_travel('Jerusalem', 'Jerusalem'), 'steps').length)
  end

  def test_get_google_data_for_travel2
    assert(get_nested_hash_value(get_google_data_for_travel('Jerusalem', 'Tel Aviv'), 'steps').length>1)
  end

  def test_get_google_data_for_travel3
    assert(get_nested_hash_value(get_google_data_for_travel('Jerusalem', 'Tel Aviv'), 'legs')[0]["duration"]["value"].to_f>100)
  end

end
