import 'package:flutter/material.dart';

class DescriptionWeather extends StatelessWidget {
  const DescriptionWeather({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.deepOrangeAccent),
          child: const Center(
              child: Text("Rain",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ))),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Feels like 20°C. light rain",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        )
      ],
    );
  }
}
