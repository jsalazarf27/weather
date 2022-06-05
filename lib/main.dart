import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather/api/api.dart';
import 'package:weather/repository/cities_repository.dart';
import 'package:weather/repository/weather_repository.dart';
import 'package:weather/ui/pages/cities_page.dart';
import 'package:weather/ui/pages/weather_page.dart';

import 'api/api_key.default.dart';

void main() {
  final WeatherRepository weatherRepository = WeatherRepository(
      openWeatherAPI: OpenWeatherAPI(const String.fromEnvironment(
        'API_KEY',
        defaultValue: APIKeys.openWeatherAPIKey,
      )),
      client: Client());
  runApp(MyApp(
    weatherRepository: weatherRepository,
    citiesRepository: CitiesRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;
  final CitiesRepository citiesRepository;
  const MyApp(
      {Key? key,
      required this.weatherRepository,
      required this.citiesRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      initialRoute: 'cities',
      routes: {
        'cities': (_) => CitiesPage(
              citiesRepository: citiesRepository,
              weatherRepository: weatherRepository,
            ),
        // 'cities': (_) => CitiesPage(weatherRepository: weatherRepository),
        'weather': (_) => const WeatherPage(),
      },
    );
  }
}
