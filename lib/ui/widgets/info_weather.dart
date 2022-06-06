import 'package:flutter/material.dart';

class InfoWeather extends StatelessWidget {
  static const String urlIcons = "http://openweathermap.org/img/wn/";
  final String imageWeather;
  final String tempeture;
  const InfoWeather(
      {Key? key, required this.imageWeather, required this.tempeture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.network(
        imageWeather,
        height: 100,
      ),
      Text("$tempeture°C",
          style: const TextStyle(
            fontSize: 40,
            color: Colors.black45,
          ))
    ]);
  }
}
