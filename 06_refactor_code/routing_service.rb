# weather_service.rb

require 'open-uri'
require 'json'
require 'byebug'

require './utils.rb'

GOOGLE_MAPS_API_KEY = ENV['GOOGLE_MAPS_API_KEY']
# GOOGLE_API_LIMIT = ENV['GOOGLE_API_LIMIT']

class RoutingError < StandardError
  attr_reader :object

  def initialize(object)
    @object = object
  end
end

def get_google_data_for_travel(origin, destination)
  url = "https://maps.googleapis.com/maps/api/directions/json?key=#{GOOGLE_MAPS_API_KEY}&origin=#{origin}&destination=#{destination}"
  begin
    response = open(url)
  rescue
    raise RoutingError.new(response), "Error Getting routing info"
  end
  response_body = response.read
  return JSON.parse(response_body)
end

