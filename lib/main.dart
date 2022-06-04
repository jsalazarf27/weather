import 'package:flutter/material.dart';
import 'package:weather/ui/pages/cities_page.dart';
import 'package:weather/ui/pages/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      initialRoute: 'cities',
      routes: {
        'cities': (_) => CitiesPage(),
        'weather': (_) => const WeatherPage(),
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo)),
      home: CitiesPage(),
    );
  }
}
