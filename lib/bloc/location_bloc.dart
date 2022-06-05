import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class LocationBloc implements BaseBloc {
  final _positionFetcher = PublishSubject<Position>();
  final _city = PublishSubject<String>();
  final _loading = PublishSubject<bool>();
  Stream<Position> get position => _positionFetcher.stream;
  Stream<String> get city => _city.stream;
  @override
  get isLoading => _loading.stream;

  determinePosition() async {
    _loading.sink.add(true);
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _positionFetcher.sink.addError('Location services are disabled.');
      _loading.sink.add(false);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _positionFetcher.sink.addError('Location permissions are denied');
        _loading.sink.add(false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _loading.sink.add(false);
      _positionFetcher.sink.addError(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }
    Position position = await Geolocator.getCurrentPosition();
    _loading.sink.add(false);
    _positionFetcher.sink.add(position);
  }

  getCity(double latitude, double longitude) async {
    _loading.sink.add(true);
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude, longitude);
    _loading.sink.add(false);
    _city.sink.add(placemark[0].locality!);
  }

  @override
  void dispose() {
    _positionFetcher.close();
    _loading.close();
  }
}
