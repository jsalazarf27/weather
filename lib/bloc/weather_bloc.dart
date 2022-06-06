import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/repository/weather_repository.dart';

import 'base_bloc.dart';

class WeatherBloc implements BaseBloc {
  final WeatherRepository weatherRepository;

  final _weatherFetcher = PublishSubject<WeatherData>();
  final _loading = PublishSubject<bool>();

  WeatherBloc({required this.weatherRepository});

  Stream<WeatherData> get weather => _weatherFetcher.stream;
  @override
  get isLoading => _loading.stream;

  getWeather({required String city}) async {
    _loading.sink.add(true);
    try {
      WeatherData? currentWeather =
          await weatherRepository.getWeather(city: city);
      if (currentWeather != null) {
        _weatherFetcher.sink.add(currentWeather);
      } else {
        _weatherFetcher.sink.addError("City not found");
      }
      _loading.sink.add(false);
    } on LoadWeatherException catch (error) {
      _loading.sink.add(false);
      _weatherFetcher.sink.addError(error.message);
    }
  }

  @override
  void dispose() {
    _weatherFetcher.close();
    _loading.close();
  }
}
