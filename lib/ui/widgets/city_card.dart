import 'package:flutter/material.dart';
import 'package:weather/models/cities.dart';

class CityCard extends StatelessWidget {
  final Cities city;
  final Function() onTap;
  const CityCard({Key? key, required this.city, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey,
        child: Icon(Icons.cloudy_snowing),
      ),
      title: Text(city.name!),
      subtitle: Text(city.country!),
      trailing: const Icon(Icons.location_city),
      onTap: onTap,
    );
  }
}
