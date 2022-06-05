import 'package:flutter/material.dart';

class InfoWeather extends StatelessWidget {
  static const String urlIcons = "http://openweathermap.org/img/wn/";
  final String? iconId;
  final String tempeture;
  const InfoWeather({Key? key, this.iconId, required this.tempeture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.network(
        "$urlIcons$iconId@2x.png",
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
