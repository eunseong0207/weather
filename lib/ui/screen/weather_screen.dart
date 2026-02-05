import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/weather_view_model.dart';

/// 사용자에게 날씨 정보를 보여주는 UI 화면 (View)
/// ViewModel의 상태를 구독(watch)하여 화면을 갱신합니다.
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WeatherViewModel>().fetchWeather();
    });
  }

  // 날씨 코드에 따른 아이콘 매핑
  IconData _getWeatherIcon(int code) {
    switch (code) {
      case 0:
        return Icons.wb_sunny;
      case 1:
      case 2:
      case 3:
        return Icons.wb_cloudy;
      case 45:
      case 48:
        return Icons.cloud; // Fog
      case 51:
      case 53:
      case 55:
      case 61:
      case 63:
      case 65:
      case 80:
      case 81:
      case 82:
        return Icons.beach_access; // Rain
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return Icons.ac_unit; // Snow
      case 95:
      case 96:
      case 99:
        return Icons.flash_on; // Thunderstorm
      default:
        return Icons.wb_sunny;
    }
  }

  // 날씨 코드에 따른 배경 그라디언트 매핑
  List<Color> _getBackgroundColors(int code) {
    if (code == 0) {
      return [Colors.orange, Colors.amber]; // 맑음
    } else if (code >= 1 && code <= 3) {
      return [Colors.blueAccent, Colors.lightBlue.shade100]; // 구름 조금
    } else if ((code >= 51 && code <= 67) || (code >= 80 && code <= 82)) {
      return [Colors.grey.shade700, Colors.grey.shade400]; // 비
    } else if ((code >= 71 && code <= 77) || (code >= 85 && code <= 86)) {
      return [Colors.lightBlue.shade900, Colors.lightBlue.shade300]; // 눈
    } else {
      return [Colors.blue, Colors.lightBlueAccent]; // 기본
    }
  }

  // 날씨 코드에 따른 상태 텍스트
  String _getWeatherStatusText(int code) {
    switch (code) {
      case 0:
        return '맑음';
      case 1:
      case 2:
      case 3:
        return '구름 많음';
      case 45:
      case 48:
        return '안개';
      case 51:
      case 53:
      case 55:
        return '이슬비';
      case 61:
      case 63:
      case 65:
        return '비';
      case 71:
      case 73:
      case 75:
        return '눈';
      case 95:
      case 96:
      case 99:
        return '뇌우';
      default:
        return '알 수 없음';
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WeatherViewModel>();

    return Scaffold(
      extendBodyBehindAppBar: true, // 앱바 뒤로 배경 확장
      appBar: AppBar(
        title: const Text('날씨 앱', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: viewModel.weather != null
                ? _getBackgroundColors(viewModel.weather!.weatherCode)
                : [Colors.blue, Colors.lightBlueAccent],
          ),
        ),
        child: viewModel.isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : viewModel.weather == null
            ? const Center(
                child: Text(
                  '날씨 정보를 가져올 수 없습니다.',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getWeatherIcon(viewModel.weather!.weatherCode),
                      size: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _getWeatherStatusText(viewModel.weather!.weatherCode),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${viewModel.weather!.temperature}°C',
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildInfoColumn(
                          '풍속',
                          '${viewModel.weather!.windSpeed} km/h',
                        ),
                        const SizedBox(width: 40),
                        _buildInfoColumn(
                          '시간',
                          viewModel.weather!.isDay ? "낮" : "밤",
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton.icon(
                      onPressed: () {
                        viewModel.fetchWeather();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('새로고침'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.3),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
