import 'package:flutter/material.dart';
import 'package:weather/models/city.dart';

class CitiesPage extends StatelessWidget {
  final List<Cities> cities = List<Cities>.generate(
    20,
    (i) =>
        MessageItem(City('Name $i', 'Contry $i', 'Location $i', 'Location $i')),
  );
  CitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cities"),
        ),
        body: ListView.builder(
          itemCount: cities.length,
          itemBuilder: (context, index) => Card(
              elevation: 6,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromARGB(255, 51, 174, 235),
                  child: Icon(Icons.cloudy_snowing),
                ),
                title: cities[index].buildTitle(context),
                subtitle: cities[index].buildSubtitle(context),
                trailing: const Icon(Icons.place),
              )),
        ));
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
