import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../../features/treks/presentation/viewmodels/trek_viewmodel.dart';
import '../../features/treks/data/models/trek_model.dart';

class ExploreTab extends ConsumerStatefulWidget {
  const ExploreTab({super.key});

  @override
  ConsumerState<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends ConsumerState<ExploreTab> {
  final _searchController = TextEditingController();
  String _selectedDifficulty = '';
  bool _searchFocused = false;
  final _focusNode = FocusNode();

  // Gyroscope
  double _gyroY = 0.0;
  StreamSubscription<GyroscopeEvent>? _gyroSub;

  @override
  void initState() {
    super.initState();
    _gyroSub = gyroscopeEventStream().listen((event) {
      if (mounted) {
        setState(() {
          _gyroY = event.y.clamp(-2.0, 2.0);
        });
      }
    });
    _focusNode.addListener(() {
      setState(() => _searchFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _gyroSub?.cancel();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Color _diffColor(String d) {
    if (d == 'Easy') return const Color(0xFF2E7D32);
    if (d == 'Moderate') return const Color(0xFFE65100);
    return const Color(0xFFC62828);
  }

  Color _diffBg(String d) {
    if (d == 'Easy') return const Color(0xFFE8F5E9);
    if (d == 'Moderate') return const Color(0xFFFFF3E0);
    return const Color(0xFFFFEBEE);
  }

  @override
  Widget build(BuildContext context) {
    final trekState = ref.watch(trekViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: CustomScrollView(
        slivers: [
          // premium header
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            backgroundColor: const Color(0xFF00695C),
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF004D40), Color(0xFF00897B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // decorative circles
                  Positioned(
                    top: -20,
                    right: -20,
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.06),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 80,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Explore',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Discover your next adventure',
                            style:
                                TextStyle(color: Colors.white60, fontSize: 13),
                          ),
                          const SizedBox(height: 14),
                          // search bar embedded in header
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: _searchFocused
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      )
                                    ]
                                  : [],
                            ),
                            child: TextField(
                              controller: _searchController,
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                hintText: 'Search treks...',
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade400, fontSize: 14),
                                prefixIcon: const Icon(Icons.search,
                                    color: Color(0xFF00695C), size: 20),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                              onChanged: (value) {
                                ref
                                    .read(trekViewModelProvider.notifier)
                                    .loadTreks(
                                      search: value,
                                      difficulty: _selectedDifficulty,
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // filter chips
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFFF5F7F5),
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Easy', 'Moderate', 'Hard'].map((d) {
                    final isSelected =
                        _selectedDifficulty == (d == 'All' ? '' : d);
                    final color = d == 'All'
                        ? const Color(0xFF00695C)
                        : d == 'Easy'
                            ? const Color(0xFF2E7D32)
                            : d == 'Moderate'
                                ? const Color(0xFFE65100)
                                : const Color(0xFFC62828);
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDifficulty = d == 'All' ? '' : d;
                          });
                          ref.read(trekViewModelProvider.notifier).loadTreks(
                                search: _searchController.text,
                                difficulty: _selectedDifficulty,
                              );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? color : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? color.withOpacity(0.3)
                                    : Colors.black.withOpacity(0.05),
                                blurRadius: isSelected ? 8 : 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            d,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          // trek list
          if (trekState.isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (trekState.error != null)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: Colors.red),
                    const SizedBox(height: 8),
                    Text('Error: ${trekState.error}'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () =>
                          ref.read(trekViewModelProvider.notifier).loadTreks(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else if (trekState.treks.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text('No treks found')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final trek = trekState.treks[index];
                    return _TrekCard(trek: trek, gyroY: _gyroY);
                  },
                  childCount: trekState.treks.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TrekCard extends StatelessWidget {
  final TrekModel trek;
  final double gyroY;
  const _TrekCard({required this.trek, required this.gyroY});

  Color get _diffColor {
    if (trek.difficulty == 'Easy') return const Color(0xFF2E7D32);
    if (trek.difficulty == 'Moderate') return const Color(0xFFE65100);
    return const Color(0xFFC62828);
  }

  Color get _diffBg {
    if (trek.difficulty == 'Easy') return const Color(0xFFE8F5E9);
    if (trek.difficulty == 'Moderate') return const Color(0xFFFFF3E0);
    return const Color(0xFFFFEBEE);
  }

  @override
  Widget build(BuildContext context) {
    final localImg = trek.localImage;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/trek-detail',
        arguments: trek.id,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image with parallax + gradient overlay
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // parallax image
                    ClipRect(
                      child: Transform.translate(
                        offset: Offset(gyroY * 12, 0),
                        child: localImg.isNotEmpty
                            ? Image.asset(
                                localImg,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color:
                                      const Color(0xFF00695C).withOpacity(0.2),
                                  child: const Icon(Icons.terrain,
                                      size: 60, color: Color(0xFF00695C)),
                                ),
                              )
                            : Container(
                                color: const Color(0xFF00695C).withOpacity(0.2),
                                child: const Icon(Icons.terrain,
                                    size: 60, color: Color(0xFF00695C)),
                              ),
                      ),
                    ),
                    // gradient overlay bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.55),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    // price badge bottom left
                    Positioned(
                      bottom: 12,
                      left: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00695C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Rs. ${trek.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    // difficulty badge top right
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: _diffBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          trek.difficulty,
                          style: TextStyle(
                            color: _diffColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // info section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trek.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 13, color: Color(0xFF00695C)),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          trek.location,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.schedule, size: 13, color: Colors.grey),
                      const SizedBox(width: 3),
                      Text(
                        '${trek.duration} ${trek.duration == 1 ? 'day' : 'days'}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
