import 'package:flutter/material.dart';
import '../core/api/api_client.dart';
import '../core/api/api_endpoints.dart';
import '../core/services/storage/token_storage.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _locationController = TextEditingController();
  Map<String, dynamic>? _weather;
  bool _isLoading = false;
  String? _error;

  final List<String> _popularLocations = [
    'Pokhara',
    'Kathmandu',
    'Namche',
    'Lukla',
    'Manang',
  ];

  Future<void> _fetchWeather(String location) async {
    if (location.isEmpty) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final token = await TokenStorage().getToken();
      final dio = token != null
          ? ApiClient.createAuthDio(token)
          : ApiClient.createDio();
      final res = await dio.get(ApiEndpoints.weather(location));
      setState(() {
        _weather = res.data['data'] ?? res.data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Could not fetch weather. Try again!';
        _isLoading = false;
      });
    }
  }

  IconData _getWeatherIcon(String? condition) {
    if (condition == null) return Icons.wb_sunny;
    final c = condition.toLowerCase();
    if (c.contains('rain')) return Icons.grain;
    if (c.contains('cloud')) return Icons.cloud;
    if (c.contains('snow')) return Icons.ac_unit;
    if (c.contains('storm')) return Icons.thunderstorm;
    return Icons.wb_sunny;
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        backgroundColor: const Color(0xFF00695C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // search bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      hintText: 'Enter location (e.g. Pokhara)',
                      prefixIcon: const Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: _fetchWeather,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () =>
                      _fetchWeather(_locationController.text.trim()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00695C),
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // popular locations
            const Text('Popular Locations',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _popularLocations.map((loc) {
                return ActionChip(
                  label: Text(loc),
                  onPressed: () {
                    _locationController.text = loc;
                    _fetchWeather(loc);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // weather result
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_error != null)
              Center(
                child: Column(
                  children: [
                    const Icon(Icons.cloud_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 8),
                    Text(_error!, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              )
            else if (_weather != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00695C), Color(0xFF004D40)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      _weather!['location'] ?? _locationController.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Icon(
                      _getWeatherIcon(_weather!['condition']),
                      size: 64,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_weather!['temperature'] ?? '--'}°C',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _weather!['condition'] ?? '',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _WeatherInfo(
                          icon: Icons.water_drop,
                          label: 'Humidity',
                          value: '${_weather!['humidity'] ?? '--'}%',
                        ),
                        _WeatherInfo(
                          icon: Icons.air,
                          label: 'Wind',
                          value: '${_weather!['windSpeed'] ?? '--'} km/h',
                        ),
                      ],
                    ),
                  ],
                ),
              )
            else
              Center(
                child: Column(
                  children: const [
                    Icon(Icons.wb_sunny, size: 64, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Search a location to see weather',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
