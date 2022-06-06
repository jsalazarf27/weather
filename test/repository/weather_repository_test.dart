import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:weather/api/api.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/repository/weather_repository.dart';

import '../common.dart';

void main() {
  group('weather', () {
    test('status=200', () async {
      final mockClient = MockClient((request) async {
        return Response(json.encode(jsonResponseWeather), 200);
      });
      final api = OpenWeatherAPI('apiKey');
      final weatherRepository =
          WeatherRepository(openWeatherAPI: api, client: mockClient);
      final expectedResponse = WeatherData.fromJson(jsonResponseWeather);
      final actualResponse =
          await weatherRepository.getWeather(city: "Medellin");
      expect(actualResponse!.toJson(), equals(expectedResponse.toJson()));
    });

    test('status != 200', () async {
      final mockClient = MockClient((request) async {
        return Response(json.encode(jsonResponseWeather), 500);
      });
      final api = OpenWeatherAPI('apiKey');
      final weatherRepository =
          WeatherRepository(openWeatherAPI: api, client: mockClient);
      expect(
        () async => await weatherRepository.getWeather(city: "Medellin"),
        throwsA(predicate(
            (e) => e is LoadWeatherException && e.message == "Error Api")),
      );
    });

    test('status == 404', () async {
      final mockClient = MockClient((request) async {
        return Response(json.encode(jsonResponseWeather), 404);
      });
      final api = OpenWeatherAPI('apiKey');
      final weatherRepository =
          WeatherRepository(openWeatherAPI: api, client: mockClient);
      expect(
        () async => await weatherRepository.getWeather(city: "Medellin"),
        throwsA(predicate((e) =>
            e is LoadWeatherException &&
            e.message == "Open weather not found")),
      );
    });

    test('status == 401', () async {
      final mockClient = MockClient((request) async {
        return Response(json.encode(jsonResponseWeather), 401);
      });
      final api = OpenWeatherAPI('apiKey');
      final weatherRepository =
          WeatherRepository(openWeatherAPI: api, client: mockClient);
      expect(
        () async => await weatherRepository.getWeather(city: "Medellin"),
        throwsA(predicate((e) =>
            e is LoadWeatherException && e.message == "Invalid Api key")),
      );
    });
  });
}
