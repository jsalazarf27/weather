import 'package:flutter/material.dart';

import '../../models/city.dart';

class CityCard extends StatelessWidget {
  final Cities city;
  const CityCard({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey,
        child: Icon(Icons.cloudy_snowing),
      ),
      title: city.buildTitle(context),
      subtitle: city.buildSubtitle(context),
      trailing: const Icon(Icons.location_city),
      onTap: () => Navigator.pushNamed(context, 'weather', arguments: city),
    );
  }
}

abstract class Cities {
  Widget buildTitle(BuildContext context);

  Widget buildSubtitle(BuildContext context);
}

class MessageItem implements Cities {
  final City city;

  MessageItem(this.city);

  @override
  Widget buildTitle(BuildContext context) => Text(city.name);

  @override
  Widget buildSubtitle(BuildContext context) => Text(city.country);
}
