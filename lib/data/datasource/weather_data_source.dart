import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/weather_model.dart';

/// 실제 데이터 원천(API)에 접근하여 데이터를 가져오는 역할 (Data Source)
/// http 패키지를 사용하여 Open-Meteo API를 호출합니다.
class WeatherDataSource {
  Future<WeatherModel> getWeather(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true',
      ),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final currentWeather = json['current_weather'];
      return WeatherModel.fromJson(currentWeather);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
