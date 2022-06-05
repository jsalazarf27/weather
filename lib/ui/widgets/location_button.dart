import 'package:flutter/material.dart';

class LocationButton extends StatelessWidget {
  final Function() onPressed;
  const LocationButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.deepOrangeAccent,
      child: const Icon(Icons.person_pin_circle),
    );
  }
}
