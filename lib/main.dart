import 'package:flutter/material.dart';
import 'api_client.dart';
import 'weather_model.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF212121),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final WeatherApiClient apiClient = WeatherApiClient();
  WeatherModel? weatherModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getWeatherData();
  }

  Future<void> _getWeatherData() async {
    try {
      final data = await apiClient.request();
      setState(() {
        weatherModel = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Weather', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: isLoading
          // PERBAIKAN TYPO: CircularProgressIndicator, bukan CircularPaddingIndicator
          ? const Center(child: CircularProgressIndicator())
          : weatherModel == null 
              ? const Center(child: Text('Gagal mengambil data cuaca', style: TextStyle(color: Colors.red)))
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Icon(
                        weatherModel!.current.isDay == 1 ? Icons.sunny : Icons.nightlight_round,
                        color: Colors.amber,
                        size: 80,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${weatherModel!.current.temperature}°C',
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Wind: ${weatherModel!.current.windspeed} km/h',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 40),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Hourly Forecast',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: weatherModel!.hourly.temperatures.length,
                          itemBuilder: (context, index) {
                            final time = DateTime.parse(weatherModel!.hourly.time[index]);
                            final temp = weatherModel!.hourly.temperatures[index];
                            return Container(
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[800],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(DateFormat.j().format(time)),
                                  const SizedBox(height: 10),
                                  const Icon(Icons.cloud, color: Colors.white, size: 24),
                                  const SizedBox(height: 10),
                                  Text('${temp.toStringAsFixed(1)}°C'),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}