import 'package:flutter/material.dart';

import '../../models/city.dart';
import 'city_card.dart';

class CitiesListView extends StatelessWidget {
  final List<City>? cities;
  final Function(String) onTapItem;

  const CitiesListView(
      {Key? key, required this.cities, required this.onTapItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: cities == null ? 0 : cities!.length,
            itemBuilder: (context, index) => Card(
                  elevation: 6,
                  margin: const EdgeInsets.all(10),
                  child: CityCard(city: cities![index], onTap: onTapItem),
                )));
  }
}
