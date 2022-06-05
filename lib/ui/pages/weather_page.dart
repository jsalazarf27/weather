import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';

import '../widgets/description_weather.dart';
import '../widgets/details_weather.dart';
import '../widgets/info_city.dart';
import '../widgets/info_weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeatherData weatherData =
        ModalRoute.of(context)!.settings.arguments as WeatherData;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(
            color: Colors.deepOrangeAccent,
          )),
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
            children: [
              InfoCity(
                  city: weatherData.name!,
                  country: weatherData.sys!.country!,
                  coord: weatherData.coord!),
              InfoWeather(
                iconId: weatherData.weather![0].icon,
                tempeture: weatherData.main!.temp!,
              ),
              DescriptionWeather(
                main: weatherData.weather![0].main!,
                feelLikes: weatherData.main!.feelsLike!,
                descripton: weatherData.weather![0].description!,
              ),
              DetailsWeather(
                  humidity: weatherData.main!.humidity!,
                  visibility: weatherData.visibility!,
                  maxTemp: weatherData.main!.tempMax!,
                  minTemp: weatherData.main!.tempMin!,
                  pressure: weatherData.main!.pressure!,
                  speedWind: weatherData.wind!.speed!)
            ],
          ),
        ),
      ),
    );
  }
}
