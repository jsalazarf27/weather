import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../bloc/weather_bloc.dart';
import '../../models/cities.dart';
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
  List<Cities>? _citiesd;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

//Todo:pending implement rxdart
  _asyncMethod() async {
    var jsonText = await rootBundle.loadString('assets/cities.json');
    final jsonResult = json.decode(jsonText).cast<Map<String, dynamic>>();
    setState(() => _citiesd =
        jsonResult.map<Cities>((json) => Cities.fromJson(json)).toList());
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
                itemCount: _citiesd == null ? 0 : _citiesd!.length,
                itemBuilder: (context, index) => Card(
                    elevation: 6,
                    margin: const EdgeInsets.all(10),
                    child: CityCard(
                        city: _citiesd![index],
                        onTap: () => _weatherBloc.getWeather(
                            city: _citiesd![index].name!))),
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
