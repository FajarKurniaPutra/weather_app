class WeatherModel {
  final CurrentWeather current;
  final HourlyCast hourly;

  WeatherModel({required this.current, required this.hourly});

  factory WeatherModel.fromJson(Map<String, dynamic> data) {
    final currentData = data['current_weather'] as Map<String, dynamic>;
    final hourlyData = data['hourly'] as Map<String, dynamic>;

    return WeatherModel(
      current: CurrentWeather.fromJson(currentData),
      hourly: HourlyCast.fromJson(hourlyData),
    );
  }
}

class CurrentWeather {
  final double temperature;
  final double windspeed;
  final int weathercode;
  final int isDay;

  CurrentWeather({
    required this.temperature,
    required this.windspeed,
    required this.weathercode,
    required this.isDay,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> data) {
    return CurrentWeather(
      // PERBAIKAN: Menggunakan (as num).toDouble() untuk mencegah crash saat API mereturn nilai bulat (integer)
      temperature: (data['temperature'] as num).toDouble(),
      windspeed: (data['windspeed'] as num).toDouble(),
      weathercode: data['weathercode'] as int,
      isDay: data['is_day'] as int,
    );
  }
}

class HourlyCast {
  final List<String> time;
  final List<double> temperatures;

  HourlyCast({required this.time, required this.temperatures});

  factory HourlyCast.fromJson(Map<String, dynamic> data) {
    return HourlyCast(
      time: List<String>.from(data['time']),
      // PERBAIKAN: List of dynamic harus dikonversi dengan aman
      temperatures: List<double>.from((data['temperature_2m'] as List).map((e) => (e as num).toDouble())),
    );
  }
}
