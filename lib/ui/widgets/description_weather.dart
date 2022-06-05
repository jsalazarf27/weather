import 'package:flutter/material.dart';

class DescriptionWeather extends StatelessWidget {
  final String main;
  final int feelLikes;
  final String descripton;

  const DescriptionWeather(
      {Key? key,
      required this.main,
      required this.feelLikes,
      required this.descripton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.deepOrangeAccent),
          child: Center(
              child: Text(main,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ))),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Feels like $feelLikes°C $descripton",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        )
      ],
    );
  }
}
