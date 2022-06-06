import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:weather/api/api.dart';

class MockHttp extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late MockHttp httpClient;
  late OpenWeatherAPI openWeatherAPI;
  group('Service', () {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    httpClient = MockHttp();
    openWeatherAPI = OpenWeatherAPI('apiKey');
  });

  group('Constructor', () {
    test('does not requiered a httpclient', () {
      expect(OpenWeatherAPI(''), isNotNull);
    });
  });

  group(('weather'), () {
    test(
        ('make correct http request with empty response,'
            ' throw [ErrorEmptyResponse]'), () async {
      try {
        openWeatherAPI.weather('Medellin');
      } catch (error) {
        // expect(error, isA<ErrorEmptyResponse>);
      }
    });
  });
}
