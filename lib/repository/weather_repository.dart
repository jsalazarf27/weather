import 'dart:convert';
import 'dart:io';

import 'package:weather/api/api.dart';

import 'package:http/http.dart' as http;

import '../models/weather.dart';

class LoadWeatherException implements Exception {
  final message;

  LoadWeatherException(this.message);
}

class WeatherRepository {
  final OpenWeatherAPI openWeatherAPI;
  final http.Client client;

  WeatherRepository({required this.openWeatherAPI, required this.client});

  Future<WeatherData?> getWeather({required String city}) => _getData(
        uri: openWeatherAPI.weather(city),
        builder: (data) => WeatherData.fromJson(data),
      );

  Future<T?> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        case 401:
          throw LoadWeatherException("Invalid Api key");
        case 404:
          throw LoadWeatherException("Open weather not found");
        default:
          throw LoadWeatherException("Error Api");
      }
    } on SocketException catch (_) {
      throw LoadWeatherException("No internet connection");
    }
  }
}
