import '../entity/weather_entity.dart';

/// 데이터 계층과 도메인 계층을 연결하는 인터페이스 (Repository)
/// 구현체는 Data Layer에 위치합니다.
abstract interface class WeatherRepository {
  Future<WeatherEntity> getWeather(double latitude, double longitude);
}
