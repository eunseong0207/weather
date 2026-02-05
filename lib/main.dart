import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/data_source/weather_data_source.dart';
import 'data/repository/weather_repository_impl.dart';
import 'domain/use_case/get_weather_use_case.dart';
import 'ui/screen/weather_screen.dart';
import 'ui/view_model/weather_view_model.dart';

void main() {
  runApp(const MyApp());
}

/// 앱의 진입점.
/// 의존성 주입(Dependency Injection)을 설정하고 화면을 띄웁니다.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        // ViewModel을 생성할 때 필요한 의존성들을 순차적으로 주입합니다.
        // DataSource -> Repository -> UseCase -> ViewModel
        create: (_) {
          final dataSource = WeatherDataSource();
          final repository = WeatherRepositoryImpl(dataSource);
          final useCase = GetWeatherUseCase(repository);
          return WeatherViewModel(useCase);
        },
        child: const WeatherScreen(),
      ),
    );
  }
}
