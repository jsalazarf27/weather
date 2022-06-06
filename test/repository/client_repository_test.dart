import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/models/city.dart';
import 'package:weather/repository/cities_repository.dart';

import '../common.dart';
import 'client_repository_test.mocks.dart';

class CitiesRepositoryTest extends Mock implements CitiesRepository {}

@GenerateMocks([CitiesRepositoryTest])
void main() {
  late MockCitiesRepositoryTest mockCitiesRepository;
  setUpAll(() {
    mockCitiesRepository = MockCitiesRepositoryTest();
  });
  test('cities are correct', () async {
    when(mockCitiesRepository.getCities()).thenAnswer((_) async {
      return listCities;
    });
    var result = await mockCitiesRepository.getCities();
    expect(result, isInstanceOf<List<City>>());
  });

  test(' cities are error', () async {
    when(mockCitiesRepository.getCities()).thenAnswer((_) async {
      return Future.error('error');
    });
    try {
      await mockCitiesRepository.getCities();
    } catch (e) {
      expect(e, 'error');
    }
  });
}
