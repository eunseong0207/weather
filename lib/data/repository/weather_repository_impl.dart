import '../../domain/entity/weather_entity.dart';
import '../../domain/repository/weather_repository.dart';
import '../data_source/weather_data_source.dart';

/// WeatherRepository 인터페이스의 구현체
/// DataSource에서 데이터를 가져와 Entity로 변환하여 도메인 계층으로 전달합니다.
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDataSource _dataSource;

  WeatherRepositoryImpl(this._dataSource);

  @override
  Future<WeatherEntity> getWeather(double latitude, double longitude) async {
    final dto = await _dataSource.getWeather(latitude, longitude);
    return dto.toEntity();
  }
}
