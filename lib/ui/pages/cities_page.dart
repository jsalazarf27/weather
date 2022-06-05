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
import '../widgets/custom_dialog.dart';
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
                        cities: citiesSnapShot.data, onTapItem: _onTapItem);
                  } else if (citiesSnapShot.hasError) {
                    _showMessage(citiesSnapShot.error.toString());
                  }
                  return Container();
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
              } else if (weatherSnapshot.hasError) {
                _showMessage(weatherSnapshot.error.toString());
              }
              return Container();
            }),
        StreamBuilder(
            stream: _locationBloc.city,
            builder: (context, AsyncSnapshot<String> citySnapshot) {
              if (citySnapshot.hasData && citySnapshot.data != null) {
                _weatherBloc.getWeather(city: citySnapshot.data!);
              } else if (citySnapshot.hasError) {
                _showMessage(citySnapshot.error.toString());
              }
              return Container();
            }),
        StreamBuilder(
            stream: _locationBloc.position,
            builder: (context, AsyncSnapshot<Position> positionSnapShot) {
              if (positionSnapShot.hasData && positionSnapShot.data != null) {
                _locationBloc.getCity(positionSnapShot.data!.latitude,
                    positionSnapShot.data!.longitude);
              } else if (positionSnapShot.hasError) {
                _showMessage(positionSnapShot.error.toString());
              }
              return Container();
            }),
        ProgressIndicatorStreamBuilder(baseBloc: _citiesBloc),
        ProgressIndicatorStreamBuilder(baseBloc: _weatherBloc),
        ProgressIndicatorStreamBuilder(baseBloc: _locationBloc),
      ]),
      floatingActionButton: LocationButton(onPressed: _onPressedButton),
    );
  }

  _getCities() async {
    _citiesBloc.getCities();
  }

  _showMessage(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (contex) {
            return CustomDialog(message: message);
          });
    });
  }

  _onPressedButton() {
    _locationBloc.determinePosition();
  }

  _onTapItem(String city) {
    _weatherBloc.getWeather(city: city);
  }

  @override
  void dispose() {
    _weatherBloc.dispose();
    _citiesBloc.dispose();
    super.dispose();
  }
}
