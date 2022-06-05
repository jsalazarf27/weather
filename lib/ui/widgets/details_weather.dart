import 'package:flutter/material.dart';

class DetailsWeather extends StatelessWidget {
  final String humidity;
  final String visibility;
  final String maxTemp;
  final String minTemp;
  final String pressure;
  final String speedWind;
  const DetailsWeather({
    Key? key,
    required this.humidity,
    required this.visibility,
    required this.maxTemp,
    required this.minTemp,
    required this.pressure,
    required this.speedWind,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          DetailRow(
              leftText: "Humidity: $humidity%",
              rightText: "Visibily: $visibility"),
          DetailRow(
              leftText: "Max temp: $maxTemp°C",
              rightText: "Min temp: $minTemp°C"),
          DetailRow(
              leftText: "Pressure: $pressure hPa",
              rightText: "Speed wind: $speedWind"),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String? leftText;
  final String? rightText;
  const DetailRow({Key? key, this.leftText, this.rightText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (leftText != null) TextDetail(text: leftText!),
        if (rightText != null) TextDetail(text: rightText!),
      ],
    );
  }
}

class TextDetail extends StatelessWidget {
  final String text;
  const TextDetail({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ));
  }
}
