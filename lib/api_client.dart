import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherApiClient {
  Future<WeatherModel> request() async {
    const String url = "https://api.open-meteo.com/v1/forecast?latitude=51.5085&longitude=-0.1257&current_weather=true&hourly=temperature_2m";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsedData = jsonDecode(response.body);
      return WeatherModel.fromJson(parsedData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
