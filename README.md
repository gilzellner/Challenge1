# Challenge1

To run, on a Linux\Mac environment, 
clone the repo
please install Ruby 2.3 with Sinatra.
Then run: rackup.

sample test url:

 ✘  ~/dev/git/OutbrainChallenge   master  curl "http://localhost:9292?origin='Jerusalem'&destination='Jerusalem'&mintemp=20&maxtemp=30&maxtime=300"
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
