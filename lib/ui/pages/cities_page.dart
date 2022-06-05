import 'package:flutter/material.dart';

import '../../bloc/weather_bloc.dart';
import '../../models/city.dart';
import '../../models/weather.dart';
import '../../repository/weather_repository.dart';
import '../widgets/city_card.dart';
import '../widgets/location_button.dart';

class CitiesPage extends StatefulWidget {
  final WeatherRepository weatherRepository;
  const CitiesPage({Key? key, required this.weatherRepository})
      : super(key: key);

  @override
  _CitiesPageState createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  late WeatherBloc _weatherBloc;
  final List<City> cities = List<City>.generate(
    20,
    (i) => City('Name $i', 'Country $i', 'Location $i', 'Location $i'),
  );

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            const Image(image: AssetImage('assets/weather.png')),
            Expanded(
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) => Card(
                    elevation: 6,
                    margin: const EdgeInsets.all(10),
                    child: CityCard(
                        city: cities[index],
                        onTap: () => _weatherBloc.getWeather(city: "London")

                        /*Navigator.pushNamed(context, 'weather',
                            arguments: "city")*/
                        )),
              ),
            )
          ],
        ),
        StreamBuilder(
            stream: _weatherBloc.weather,
            builder: (context, AsyncSnapshot<WeatherData> weatherSnapshot) {
              if (weatherSnapshot.hasData) {
                WidgetsBinding.instance.addPostFrameCallback((_) =>
                    Navigator.pushNamed(context, 'weather',
                        arguments: weatherSnapshot.data));
              }
              return Container();
            }),
        StreamBuilder<bool>(
          stream: _weatherBloc.isLoading,
          builder: (context, loadingSnapshot) {
            if (loadingSnapshot.hasData && loadingSnapshot.data!) {
              return Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.grey.withOpacity(.7),
                child: const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        )
      ]),
      floatingActionButton: const LocationButton(),
    );
  }

  @override
  void dispose() {
    _weatherBloc.dispose();
    super.dispose();
  }
}
