import 'package:flutter/material.dart';
import '../../domain/entity/weather_entity.dart';
import '../../domain/use_case/get_weather_use_case.dart';

/// 화면의 상태를 관리하고 비즈니스 로직(UseCase)을 호출하는 역할 (ViewModel)
/// ChangeNotifier를 상속받아 상태 변경 시 UI에 알립니다.
class WeatherViewModel extends ChangeNotifier {
  final GetWeatherUseCase _getWeatherUseCase;
  WeatherEntity? _weather;
  bool _isLoading = false;

  WeatherViewModel(this._getWeatherUseCase);

  WeatherEntity? get weather => _weather;
  bool get isLoading => _isLoading;

  /// 날씨 정보를 가져오는 메서드
  Future<void> fetchWeather() async {
    _isLoading = true;
    notifyListeners(); // 로딩 상태 알림

    try {
      // 고정된 좌표 사용 (37.57, 126.98)
      _weather = await _getWeatherUseCase.execute(37.57, 126.98);
    } catch (e) {
      print('Error fetching weather: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // 로딩 완료 및 데이터 갱신 알림
    }
  }
}
