# Challenge1

To run, on a Linux\Mac environment, 
clone the repo
please install Ruby 2.3 with Sinatra.
Then run: rackup.

sample test url:

 ✘  ~/dev/git/OutbrainChallenge   master  curl "http://localhost:9292?origin='Jerusalem'&destination='Jerusalem'&mintemp=20&maxtemp=30&maxtime=300"

and the response:


{
  "origin": "'Jerusalem'",
  "destination": "'Jerusalem'",
  "totalDurationInMinutes": {
    "text": "1 min",
    "value": 0
  },
  "totalDistanceInMeters": 0,
  "steps": [
    {
      "distance": "1 m",
      "end_location": {
        "lat": 31.7685167,
        "lng": 35.21353130000001
      },
      "html_instructions": "Head on <b>HaPalmach St</b>",
      "weather": {
        "description": "clear sky",
        "celsiusTemp": 26.66500000000002
      }
    }
  ],
  "travelAdvice": true
}%

To run tests:

 ~/dev/git/OutbrainChallenge   master ●  ruby test_weather_service.rb
 
Loaded suite test_weather_service
Started
.Getting Weather for lat:0 lon:0
200
OK
.Getting Weather for lat:35.22 lon:31.77
200
OK
{"coord"=>{"lon"=>32.43, "lat"=>35.04}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10d"}], "base"=>"stations", "main"=>{"temp"=>297.99, "pressure"=>1009.41, "humidity"=>96, "temp_min"=>297.99, "temp_max"=>297.99, "sea_level"=>1029.45, "grnd_level"=>1009.41}, "wind"=>{"speed"=>1.77, "deg"=>236.502}, "rain"=>{"3h"=>0.11}, "clouds"=>{"all"=>48}, "dt"=>1476004596, "sys"=>{"message"=>0.0029, "country"=>"CY", "sunrise"=>1475985107, "sunset"=>1476026543}, "id"=>146137, "name"=>"Polis", "cod"=>200}
.

Finished in 0.806707 seconds.

3 tests, 3 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
100% passed
3.72 tests/s, 3.72 assertions/s
 ~/dev/git/OutbrainChallenge   master ●  ruby test_routing_service.rb

Loaded suite test_routing_service
Started
...

Finished in 1.114711 seconds.
3 tests, 3 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
100% passed
2.69 tests/s, 2.69 assertions/s
