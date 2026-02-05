/// 앱 내부에서 비즈니스 로직에 사용되는 순수 날씨 데이터 모델 (Entity)
class WeatherEntity {
  final double temperature;
  final int weatherCode; // 전달해주신 'weathercode'를 담을 변수
  final double windSpeed;
  final bool isDay;
  final String time;

  const WeatherEntity({
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
    required this.isDay,
    required this.time,
  });
}
