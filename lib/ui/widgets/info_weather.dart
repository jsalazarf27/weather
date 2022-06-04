import 'package:flutter/material.dart';

class InfoWeather extends StatelessWidget {
  const InfoWeather({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.network(
        "http://openweathermap.org/img/wn/10d@2x.png",
        height: 100,
      ),
      const Text("17°C",
          style: TextStyle(
            fontSize: 40,
            color: Colors.black45,
          ))
    ]);
  }
}
