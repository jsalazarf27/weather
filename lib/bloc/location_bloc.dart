import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class LocationBloc implements BaseBloc {
  final _positionFetcher = PublishSubject<Position>();
  final _loading = PublishSubject<bool>();
  Stream<Position> get position => _positionFetcher.stream;
  @override
  get isLoading => _loading.stream;

  determinePosition() async {
    _loading.sink.add(true);
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _positionFetcher.sink.addError('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _positionFetcher.sink.addError('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _positionFetcher.sink.addError(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position positin = await Geolocator.getCurrentPosition();
    _positionFetcher.sink.add(positin);
  }

  Future<List<Placemark>> getAddress(double latitude, double longitude) async {
    return await placemarkFromCoordinates(latitude, longitude);
  }

  @override
  void dispose() {
    _positionFetcher.close();
    _loading.close();
  }
}
