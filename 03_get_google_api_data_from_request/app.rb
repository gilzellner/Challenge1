# app.rb
require 'sinatra'
require 'open-uri'

API_KEY = ENV['GOOGLE_MAPS_API_KEY']


def get_google_data_for_travel(source, destination)
  url = "https://maps.googleapis.com/maps/api/directions/json?key=#{API_KEY}&origin=#{source}&destination=#{destination}"
  response = open(url)
  response_status = response.status
  response_body = response.read
  return response_body, response_status
end

class ShowRequest < Sinatra::Base
  get '/?:source?/?:destination?/?:mintemp?/?:maxtemp?/?:maxtime?' do
    google_api_data = get_google_data_for_travel(params[:source], params[:destination])
    "source: #{params[:source]}, destination: #{params[:destination]},
      mintemp: #{params[:mintemp]}, maxtemp: #{params[:maxtemp]}, maxtime: #{params[:maxtime]}
      Google API data: #{google_api_data}"
  end
end

