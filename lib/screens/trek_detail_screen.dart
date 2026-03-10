import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/treks/data/datasources/trek_remote_datasource.dart';
import '../features/treks/data/models/trek_model.dart';
import '../core/api/api_client.dart';
import '../core/services/storage/token_storage.dart';
import '../core/api/api_client.dart';
import '../core/api/api_endpoints.dart';
import '../core/services/storage/token_storage.dart';

class TrekDetailScreen extends ConsumerStatefulWidget {
  const TrekDetailScreen({super.key});

  @override
  ConsumerState<TrekDetailScreen> createState() => _TrekDetailScreenState();
}

class _TrekDetailScreenState extends ConsumerState<TrekDetailScreen> {
  TrekModel? _trek;
  bool _isLoading = true;
  String? _error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final trekId = ModalRoute.of(context)!.settings.arguments as String;
    _loadTrek(trekId);
  }

  Future<void> _loadTrek(String id) async {
    try {
      final token = await TokenStorage().getToken();
      final dio = token != null
          ? ApiClient.createAuthDio(token)
          : ApiClient.createDio();
      final datasource = TrekRemoteDatasource(dio);
      final data = await datasource.getTrekById(id);
      setState(() {
        _trek = TrekModel.fromJson(data);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Error: $_error')),
      );
    }

    final trek = _trek!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // hero image header
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                trek.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                ),
              ),
              background: trek.image.isNotEmpty
                  ? Image.network(
                      trek.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFF00695C),
                        child: const Icon(Icons.terrain,
                            size: 80, color: Colors.white),
                      ),
                    )
                  : Container(
                      color: const Color(0xFF00695C),
                      child: const Icon(Icons.terrain,
                          size: 80, color: Colors.white),
                    ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // info chips
                  Row(
                    children: [
                      _InfoChip(
                        icon: Icons.location_on,
                        label: trek.location,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      _InfoChip(
                        icon: Icons.terrain,
                        label: trek.difficulty,
                        color: trek.difficulty == 'Easy'
                            ? Colors.green
                            : trek.difficulty == 'Moderate'
                                ? Colors.orange
                                : Colors.red,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // duration and price
                  Row(
                    children: [
                      _InfoChip(
                        icon: Icons.calendar_today,
                        label: '${trek.duration} days',
                        color: Colors.purple,
                      ),
                      const SizedBox(width: 8),
                      _InfoChip(
                        icon: Icons.attach_money,
                        label: 'Rs. ${trek.price.toStringAsFixed(0)}',
                        color: Colors.teal,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // description
                  const Text(
                    'About this Trek',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    trek.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // weather section
                  const Text(
                    'Weather at Location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _WeatherWidget(location: trek.location.split(',')[0].trim()),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // book now button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/book',
              arguments: {
                'trekId': trek.id,
                'trekName': trek.name,
                'price': trek.price,
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00695C),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'Book Now - Rs. ${trek.price.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherWidget extends StatefulWidget {
  final String location;
  const _WeatherWidget({required this.location});

  @override
  State<_WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<_WeatherWidget> {
  Map<String, dynamic>? _weather;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final token = await TokenStorage().getToken();
      final dio = token != null
          ? ApiClient.createAuthDio(token)
          : ApiClient.createDio();
      final res = await dio.get(ApiEndpoints.weather(widget.location));
      if (mounted) {
        setState(() {
          _weather = res.data['data'] ?? res.data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_weather == null) {
      return const Text('Weather unavailable',
          style: TextStyle(color: Colors.grey));
    }
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00695C), Color(0xFF004D40)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Icon(Icons.wb_sunny, color: Colors.white, size: 36),
              const SizedBox(height: 4),
              Text(
                '${_weather!['temperature'] ?? '--'}°C',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _weather!['condition'] ?? '',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Icon(Icons.water_drop, color: Colors.white70, size: 16),
                const SizedBox(width: 4),
                Text('${_weather!['humidity'] ?? '--'}% humidity',
                    style: const TextStyle(color: Colors.white)),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                const Icon(Icons.air, color: Colors.white70, size: 16),
                const SizedBox(width: 4),
                Text('${_weather!['windSpeed'] ?? '--'} km/h wind',
                    style: const TextStyle(color: Colors.white)),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
