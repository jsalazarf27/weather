import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("weather"),
      ),
      body: const Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}
