import '../../domain/entity/weather_entity.dart';

/// 서버 API 응답 데이터를 받기 위한 객체 (Data Transfer Object)
/// JSON 파싱 및 Entity 변환 역할을 담당합니다.
class WeatherDto {
  final double temperature;
  final double windspeed;
  final int weathercode;
  final int isDay;
  final String time;

  WeatherDto({
    required this.temperature,
    required this.windspeed,
    required this.weathercode,
    required this.isDay,
    required this.time,
  });

  /// JSON 데이터를 DTO로 변환하는 팩토리 생성자
  factory WeatherDto.fromJson(Map<String, dynamic> json) {
    return WeatherDto(
      temperature: (json['temperature'] as num).toDouble(),
      windspeed: (json['windspeed'] as num).toDouble(),
      weathercode: json['weathercode'] as int,
      isDay: json['is_day'] as int,
      time: json['time'] as String,
    );
  }

  /// DTO를 앱 내부에서 사용할 Entity로 변환하는 메서드 (Mapper)
  WeatherEntity toEntity() {
    return WeatherEntity(
      temperature: temperature,
      weatherCode: weathercode,
      windSpeed: windspeed,
      isDay: isDay == 1,
      time: time,
    );
  }
}
