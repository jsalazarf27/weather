import 'package:flutter/material.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, 'weather', arguments: "cities[index]");
      },
      backgroundColor: Colors.lightGreen,
      child: const Icon(Icons.person_pin_circle),
    );
  }
}
