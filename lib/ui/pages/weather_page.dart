import 'package:flutter/material.dart';

import '../widgets/description_weather.dart';
import '../widgets/details_weather.dart';
import '../widgets/info_city.dart';
import '../widgets/info_weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              InfoCity(),
              InfoWeather(),
              DescriptionWeather(),
              DetailsWeather()
            ],
          ),
        ),
      ),
    );
  }
}
