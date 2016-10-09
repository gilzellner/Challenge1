# app.rb
require 'sinatra'
require 'json'
# require 'byebug'
require 'recursive-open-struct'

require './utils.rb'
require './routing_service.rb'
require './weather_service.rb'

# THIS_SERVICE_API_LIMIT = ENV['THIS_SERVICE_API_LIMIT']

def get_request_data()
  return { "origin": params[:origin],
            "destination": params[:destination],
            "mintemp": params[:mintemp],
            "maxtemp": params[:maxtemp],
            "maxtime": params[:maxtime] }
end

def get_request_metadata()
  google_api_data = get_google_data_for_travel(params[:origin], params[:destination])
  request_data = get_request_data()
  return { "request_data": request_data,
         "google_api_data": google_api_data}
end

def get_steps(metadata)
  steps=get_nested_hash_value(metadata, 'steps')
  result = []
  steps.each do |step|
    weatherdata = get_weather_data_for_travel(step["end_location"]["lat"],
                                              step["end_location"]["lng"])
    result << { "distance": step["distance"]["text"],
                "end_location": step["end_location"],
                "html_instructions":step["html_instructions"],
                "weather":
                    {"description": weatherdata["weather"][0]["description"],
                     "celsiusTemp": get_celsius_from_kelvin(weatherdata["main"]["temp"])
                    }}
  end
  return result
end

def get_response(metadata)
  openstruct_metadata = RecursiveOpenStruct.new(metadata)
  {'origin': metadata[:request_data][:origin],
   'destination': metadata[:request_data][:destination],
   'totalDurationInMinutes':get_nested_hash_value(metadata,"legs")[0]["duration"],
   'totalDistanceInMeters':openstruct_metadata.google_api_data["routes"][0]["legs"][0]["distance"]["value"],
   'steps': get_steps(metadata),
   'travelAdvice': is_all_weather_between_temps?(get_all_weather_for_data(metadata),metadata[:request_data][:mintemp],metadata[:request_data][:maxtemp])
  }
end

class ShowRequest < Sinatra::Base
  get '/?:origin?/?:destination?/?:mintemp?/?:maxtemp?/?:maxtime?' do
    metadata=get_request_metadata()
    JSON.pretty_generate(get_response(metadata))
    # byebug
  end
end

