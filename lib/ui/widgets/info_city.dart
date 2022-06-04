import 'package:flutter/material.dart';

class InfoCity extends StatelessWidget {
  const InfoCity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Medellín, CO",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Text(
          "Lat: -75.5636 Long: 6.2518",
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 14,
            color: Colors.deepOrangeAccent,
          ),
        )
      ],
    );
  }
}
