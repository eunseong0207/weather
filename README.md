# Flutter Weather App 🌦️

이 프로젝트는 Flutter와 Clean Architecture를 사용하여 개발된 날씨 애플리케이션입니다.
Open-Meteo API를 활용하여 실시간 날씨 정보를 가져오며, 유지보수성과 확장성을 고려한 아키텍처로 설계되었습니다.

## 📌 주요 기능

*   **실시간 날씨 정보**: 현재 위치(혹은 지정된 좌표)의 날씨 정보를 확인할 수 있습니다.
*   **Clean Architecture**: 코드를 `Data`, `Domain`, `UI` 계층으로 분리하여 관심사를 명확히 했습니다.
*   **MVVM 패턴**: `Provider`를 사용하여 View와 Business Logic을 분리하고 상태를 효율적으로 관리합니다.
*   **Dependency Injection**: ViewModel 생성 시 필요한 의존성(UseCase, Repository, DataSource)을 주입하여 결합도를 낮췄습니다.

## 🛠️ 기술 스택 (Tech Stack)

*   **Language**: Dart
*   **Framework**: Flutter
*   **Architecture**: Clean Architecture (MVVM)
*   **Networking**: `http`
*   **State Management**: `provider`

## 📂 프로젝트 구조 (Project Structure)

프로젝트는 Clean Architecture 원칙에 따라 다음과 같이 구성되어 있습니다.

```text
lib/
├── data/               # 데이터 계층: 데이터 소스 및 모델 처리
│   ├── datasource/     # API 호출 등 실제 데이터 획득 로직
│   ├── model/          # 서버 응답 데이터 모델 (DTO)
│   └── repository/     # Domain 계층의 Repository 구현체
│
├── domain/             # 도메인 계층: 순수 비즈니스 로직
│   ├── entity/         # 앱 전반에서 사용되는 데이터 객체
│   ├── repository/     # 데이터 저장소 인터페이스 (추상화)
│   └── use_case/       # 개별 비즈니스 로직 단위
│
└── ui/                 # 프레젠테이션 계층: 사용자 인터페이스
    ├── screen/         # 실제 화면 UI 구현
    ├── view_model/     # 화면 상태 관리 및 사용자 입력 처리
    └── widget/         # 재사용 가능한 UI 컴포넌트
```

## 🚀 시작하기 (Getting Started)

### 1. 프로젝트 복제
```bash
git clone [REPOSITORY_URL]
cd flutter_weather
```

### 2. 패키지 설치
```bash
flutter pub get
```

### 3. 앱 실행
```bash
flutter run
```

## 📝 개발 노트

*   **API**: [Open-Meteo](https://open-meteo.com/)를 사용하여 별도의 인증 키 없이 날씨 데이터를 가져옵니다.
*   **DI (Dependency Injection)**: `main.dart`에서 `WeatherDataSource` -> `WeatherRepositoryImpl` -> `GetWeatherUseCase` -> `WeatherViewModel` 순서로 의존성을 주입하고 있습니다.

---
© 2024 Flutter Weather App Project
