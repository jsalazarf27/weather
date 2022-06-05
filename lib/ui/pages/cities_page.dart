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
            StreamBuilder(stream: _citiesBloc.city, builder: _citiesBuilder)
          ],
        ),
        StreamBuilder(stream: _weatherBloc.weather, builder: _weatherBuilder),
        StreamBuilder(
            stream: _locationBloc.city, builder: _locationCityBuilder),
        StreamBuilder(
            stream: _locationBloc.position, builder: _locationPositionBuilder),
        ProgressIndicatorStreamBuilder(baseBloc: _citiesBloc),
        ProgressIndicatorStreamBuilder(baseBloc: _weatherBloc),
        ProgressIndicatorStreamBuilder(baseBloc: _locationBloc),
      ]),
      floatingActionButton: LocationButton(onPressed: _onPressedFloatingButton),
    );
  }

  Widget _citiesBuilder(context, AsyncSnapshot<List<City>> citiesSnapShot) {
    if (citiesSnapShot.hasData && citiesSnapShot.data != null) {
      return CitiesListView(
          cities: citiesSnapShot.data, onTapItem: _onTapListItem);
    } else if (citiesSnapShot.hasError) {
      _showMessage(citiesSnapShot.error.toString());
    }
    return Container();
  }

  Widget _locationPositionBuilder(
      context, AsyncSnapshot<Position> positionSnapShot) {
    return _executeBuilder(
        context,
        positionSnapShot,
        () => {
              _locationBloc.getCity(positionSnapShot.data!.latitude,
                  positionSnapShot.data!.longitude)
            });
  }

  Widget _locationCityBuilder(context, AsyncSnapshot<String> citySnapshot) {
    return _executeBuilder(context, citySnapshot,
        () => {_weatherBloc.getWeather(city: citySnapshot.data!)});
  }

  Widget _weatherBuilder(context, AsyncSnapshot<WeatherData> weatherSnapshot) {
    return _executeBuilder(
        context,
        weatherSnapshot,
        () => {
              WidgetsBinding.instance.addPostFrameCallback((_) =>
                  Navigator.pushNamed(context, 'weather',
                      arguments: weatherSnapshot.data))
            });
  }

  Widget _executeBuilder(
      contex, AsyncSnapshot<dynamic> snapshot, Function() execute) {
    if (snapshot.hasData && snapshot.data != null) {
      execute();
    } else if (snapshot.hasError) {
      _showMessage(snapshot.error.toString());
    }
    return Container();
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

  _onPressedFloatingButton() {
    _locationBloc.determinePosition();
  }

  _onTapListItem(String city) {
    _weatherBloc.getWeather(city: city);
  }

  @override
  void dispose() {
    _weatherBloc.dispose();
    _citiesBloc.dispose();
    super.dispose();
  }
}
