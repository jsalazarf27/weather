import 'package:rxdart/rxdart.dart';
import 'package:weather/bloc/base_bloc.dart';
import 'package:weather/repository/cities_repository.dart';

import '../models/city.dart';

class CitiesBloc implements BaseBloc {
  final CitiesRepository citiesRepository;

  final _citiesFetcher = PublishSubject<List<City>>();
  final _loading = PublishSubject<bool>();

  CitiesBloc({required this.citiesRepository});

  Stream<List<City>> get city => _citiesFetcher.stream;

  @override
  get isLoading => _loading.stream;

  getCities() async {
    _loading.sink.add(true);
    List<City>? cities = await citiesRepository.getCities();
    _citiesFetcher.sink.add(cities);
    _loading.sink.add(false);
  }

  @override
  void dispose() {
    _citiesFetcher.close();
    _loading.close();
  }
}
