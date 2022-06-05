import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/bloc/cities_bloc.dart';
import 'package:weather/bloc/location_bloc.dart';
import 'package:weather/repository/cities_repository.dart';

import '../../bloc/weather_bloc.dart';
import '../../models/city.dart';
import '../../models/weather.dart';
import '../../repository/weather_repository.dart';
import '../widgets/cities_list_view.dart';
import '../widgets/location_button.dart';
import '../widgets/progress_indicator_stream_builder.dart';

class CitiesPage extends StatefulWidget {
  final WeatherRepository weatherRepository;
  final CitiesRepository citiesRepository;
  const CitiesPage(
      {Key? key,
      required this.weatherRepository,
      required this.citiesRepository})
      : super(key: key);

  @override
  CitiesPageState createState() => CitiesPageState();
}

class CitiesPageState extends State<CitiesPage> {
  late WeatherBloc _weatherBloc;
  late CitiesBloc _citiesBloc;
  late LocationBloc _locationBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    _citiesBloc = CitiesBloc(citiesRepository: widget.citiesRepository);
    _locationBloc = LocationBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCities();
    });
  }

  _getCities() async {
    _citiesBloc.getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            const Image(image: AssetImage('assets/weather.png')),
            StreamBuilder(
                stream: _citiesBloc.city,
                builder: (context, AsyncSnapshot<List<City>> citiesSnapShot) {
                  if (citiesSnapShot.hasData && citiesSnapShot.data != null) {
                    return CitiesListView(
                        cities: citiesSnapShot.data, onTapItem: onTapItem);
                  } else {
                    return Container();
                  }
                })
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
        ProgressIndicatorStreamBuilder(baseBloc: _citiesBloc),
        ProgressIndicatorStreamBuilder(baseBloc: _weatherBloc),
        ProgressIndicatorStreamBuilder(baseBloc: _locationBloc)
      ]),
      floatingActionButton: LocationButton(onPressed: onPressedButton),
    );
  }

  void onPressedButton() {
    StreamBuilder(
        stream: _locationBloc.position,
        builder: (context, AsyncSnapshot<Position> positionSnapShot) {
          if (positionSnapShot.hasData && positionSnapShot.data != null) {
            _locationBloc.getAddress(positionSnapShot.data!.latitude,
                positionSnapShot.data!.longitude);
            _weatherBloc.getWeather(city: "Medellin");
          }
          return Container();
        });
  }

  void onTapItem(String city) {
    _weatherBloc.getWeather(city: city);
  }

  @override
  void dispose() {
    _weatherBloc.dispose();
    _citiesBloc.dispose();
    super.dispose();
  }
}
