# OutbrainChallenge

Goal

------

In this exercise you will implement TravelAdvisor, which is a web service that gives general information on

travel destination and directions to that location. In addition it will give its advise on whether or not you should

travel to that destination.

Functionality:

----------------

TravelAdvisor is a service that accepts requests, each containing origin and destination (for example, Tel Aviv

and Jerusalem). The response should include the directions for driving from the origin to the destination, along

with weather information about every step of the way.

In addition, TravelAdvisor, once it has all information, will give its advice on whether it would be wise to travel to

that destination.

The logic for determining if it's wise or not to travel should be making sure that temperatures in every step until

the destination should be between 20-30 Celsius degrees and that the overall traveling time is below 3 hours.

The Magic (aka public apis)

---------------------------

To receive the relevant information, TravelAdvisor will use two public apis. It will collect the information needed

for its response and upon it base its final advice.

1. Travel Directions (Use the provided API key):

https://maps.googleapis.com/maps/api/directions/json?key=AIzaSyALaSwI-8n_PV-emGvj3dmKggbcL_wfsVY&origin=Toronto&destination=Montreal

2. Weather Information for a specific latitude and longitude pair (please register to obtain an API key)

http://api.openweathermap.org/data/2.5/weather?lat=0&lon=0

Response

--------

It should look something like this (mock data):

{'origin': 'Tel Aviv',

'destination': 'Jerusalem',

'totalDurationInMinutes': 13,

'totalDistanceInMeters' : 68000,

'steps': [{'duration': '5 mins',

'end_location': {'lat': 45.5067138,

'lng': -73.55859149999999},

'html_instructions': 'Keep left to continue on Autoroute 720 E',

'weather': {'celsiusTemp': 25.3, 'description': 'scattered clouds'}},

{'duration': '8 mins',

'end_location': {'lat': 45.5101458, 'lng': -73.5525249},

'html_instructions': 'Turn right onto Rue Bonsecours',

'weather': {'celsiusTemp': -45.3, 'description': 'Not fun'}}],

'travelAdvice': 'No'

}

General Guidelines

--------------------------

* The provided solution should be fairly flexible and allow for reasonable extension.

* Since external api calls could take a while to complete they should occur parallel to each other whenever

possible

* No special client is required (A browser can be used as the client).

* There are no availability/recovery requirements whatsoever.

* The Google Directions API has the notion of "leg". Since this example does not require waypoint support, you

can assume that only one leg will be returned at all times (e.g. no need to handle multiple legs).

* Please note that the weather API returns only Kelvin temperatures, while the responses should be in Celsius.

* Bear in mind that each public api has its own capping on rate. Pay attention that you are within limits during development. * There is no requirement to take them into account in the code itself*.

* Directions API - 2500 requests per day are allowed.

* Weather API - 3000 requests per minute are allowed.

* The service should be RESTful

------------------------------

* The deliverable should contain an independent and easily executable artifact

* The service should be written in Ruby

* The supplied solution should work on linux (or mac)
