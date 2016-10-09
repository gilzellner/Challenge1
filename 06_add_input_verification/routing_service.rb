require 'open-uri'
require 'json'

GOOGLE_MAPS_API_KEY = ENV['GOOGLE_MAPS_API_KEY']
# GOOGLE_API_LIMIT = ENV['GOOGLE_API_LIMIT']

def get_google_data_for_travel(origin, destination)
  url = "https://maps.googleapis.com/maps/api/directions/json?key=#{GOOGLE_MAPS_API_KEY}&origin=#{origin}&destination=#{destination}"
  response = open(url)
  # response_status = response.status
  response_body = response.read
  return JSON.parse(response_body)
end

