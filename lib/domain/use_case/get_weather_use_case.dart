import '../entity/weather_entity.dart';
import '../repository/weather_repository.dart';

/// 날씨 정보를 가져오는 비즈니스 로직 단위 (Use Case)
/// Repository를 통해 데이터를 요청합니다.
class GetWeatherUseCase {
  final WeatherRepository _repository;

  GetWeatherUseCase(this._repository);

  Future<WeatherEntity> execute(double latitude, double longitude) {
    return _repository.getWeather(latitude, longitude);
  }
}
