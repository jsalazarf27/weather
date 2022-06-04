import 'package:flutter/material.dart';
import 'package:weather/models/city.dart';
import 'package:weather/ui/widgets/location_button.dart';

import '../widgets/city_card.dart';

class CitiesPage extends StatelessWidget {
  final List<Cities> cities = List<Cities>.generate(
    20,
    (i) => MessageItem(
        City('Name $i', 'Country $i', 'Location $i', 'Location $i')),
  );
  CitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Image(image: AssetImage('assets/weather.png')),
          Expanded(
            child: ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, index) => Card(
                  elevation: 6,
                  margin: const EdgeInsets.all(10),
                  child: CityCard(city: cities[index])),
            ),
          )
        ],
      ),
      floatingActionButton: const LocationButton(),
    );
  }
}
