import 'package:weather/models/city.dart';

final jsonResponseWeather = {
  "coord": {"lon": -75.5636, "lat": 6.2518},
  "weather": [
    {
      "id": 211,
      "main": "Thunderstorm",
      "description": "thunderstorm",
      "icon": "11n"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 20.61,
    "feels_like": 20.95,
    "temp_min": 18.92,
    "temp_max": 20.82,
    "pressure": 1018,
    "humidity": 85
  },
  "visibility": 10000,
  "wind": {"speed": 5.14, "deg": 40},
  "clouds": {"all": 75},
  "dt": 1654473004,
  "sys": {
    "type": 1,
    "id": 8577,
    "country": "CO",
    "sunrise": 1654426011,
    "sunset": 1654470898
  },
  "timezone": -18000,
  "id": 3674962,
  "name": "Medellín",
  "cod": 200
};

final listCities = [
  City(city: "Medellin", country: "Colombia"),
  City(city: "Itagui", country: "Colombia"),
  City(city: "Bogota", country: "Colombia"),
  City(city: "Barranquilla", country: "Colombia"),
  City(city: "Pereira", country: "Colombia"),
  City(city: "Bucaramanga", country: "Colombia"),
  City(city: "Pasto", country: "Colombia"),
  City(city: "Envigado", country: "Colombia")
];

final jsonWeather = {
  "weather": [
    {
      "id": 211,
      "main": "Thunderstorm",
      "description": "thunderstorm",
    }
  ]
};

final jsonCities = [
  {"city": "Medellin", "country": "Colombia"},
  {"city": "Itagui", "country": "Colombia"},
  {"city": "Bogota", "country": "Colombia"},
  {"city": "Barranquilla", "country": "Colombia"},
  {"city": "Cartagena", "country": "Colombia"},
  {"city": "Pereira", "country": "Colombia"},
  {"city": "Bucaramanga", "country": "Colombia"},
  {"city": "Pasto", "country": "Colombia"},
  {"city": "Envigado", "country": "Colombia"}
];
