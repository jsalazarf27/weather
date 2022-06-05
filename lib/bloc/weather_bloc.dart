import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/repository/weather_repository.dart';

class WeatherBloc {
  final WeatherRepository weatherRepository;

  final _weatherFetcher = PublishSubject<WeatherData>();
  final _loading = PublishSubject<bool>();

  WeatherBloc({required this.weatherRepository});

  Stream<WeatherData> get weather => _weatherFetcher.stream;
  Stream<bool> get isLoading => _loading.stream;

  getWeather({required String city}) async {
    _loading.sink.add(true);

    WeatherData? currentWeather =
        await weatherRepository.getWeather(city: city);
    if (currentWeather != null) {
      _weatherFetcher.sink.add(currentWeather);
    } else {
      _weatherFetcher.sink.addError("City not found");
    }
    _loading.sink.add(false);
  }

  void dispose() {
    _weatherFetcher.close();
    _loading.close();
  }
}
