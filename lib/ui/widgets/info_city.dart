import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';

class InfoCity extends StatelessWidget {
  final String city;
  final String country;
  final Coord coord;
  const InfoCity(
      {Key? key,
      required this.city,
      required this.country,
      required this.coord})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double latitud = coord.lat!;
    final double logitud = coord.lon!;
    return Column(
      children: [
        Text(
          "$city, $country",
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Text(
          "Lat: $latitud    Long: $logitud",
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.deepOrangeAccent,
          ),
        )
      ],
    );
  }
}
