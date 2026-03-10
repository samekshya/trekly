import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
  const SavedTab({super.key});

  final List<Map<String, String>> _savedTreks = const [
    {
      'name': 'Annapurna Base Camp',
      'location': 'Kaski, Nepal',
      'duration': '5',
      'difficulty': 'Moderate',
      'image': 'assets/images/annapurna_base.jpg'
    },
    {
      'name': 'Everest View Trail',
      'location': 'Solukhumbu, Nepal',
      'duration': '3',
      'difficulty': 'Easy',
      'image': 'assets/images/nagarkot.png'
    },
    {
      'name': 'Ghorepani Poon Hill',
      'location': 'Annapurna, Nepal',
      'duration': '3',
      'difficulty': 'Easy',
      'image': 'assets/images/ghorepani.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
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
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Saved',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${_savedTreks.length} treks saved',
                            style: const TextStyle(
                                color: Colors.white60, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final trek = _savedTreks[index];
                  final difficulty = trek['difficulty']!;
                  final diffColor = difficulty == 'Easy'
                      ? const Color(0xFF2E7D32)
                      : difficulty == 'Moderate'
                          ? const Color(0xFFE65100)
                          : const Color(0xFFC62828);
                  final diffBg = difficulty == 'Easy'
                      ? const Color(0xFFE8F5E9)
                      : difficulty == 'Moderate'
                          ? const Color(0xFFFFF3E0)
                          : const Color(0xFFFFEBEE);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.07),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24)),
                          child: SizedBox(
                            height: 160,
                            width: double.infinity,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  trek['image']!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: const Color(0xFF00695C)
                                        .withOpacity(0.2),
                                    child: const Icon(Icons.terrain,
                                        size: 48, color: Color(0xFF00695C)),
                                  ),
                                ),
                                // gradient
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.45),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),
                                // difficulty badge
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: diffBg,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      difficulty,
                                      style: TextStyle(
                                        color: diffColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ),
                                // bookmark icon
                                Positioned(
                                  top: 12,
                                  left: 12,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00695C),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.bookmark,
                                        color: Colors.white, size: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // info
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      trek['name']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            size: 12, color: Color(0xFF00695C)),
                                        const SizedBox(width: 3),
                                        Text(
                                          trek['location']!,
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        const SizedBox(width: 10),
                                        const Icon(Icons.schedule,
                                            size: 12, color: Colors.grey),
                                        const SizedBox(width: 3),
                                        Text(
                                          '${trek['duration']} days',
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // remove button
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(Icons.bookmark_remove,
                                    color: Colors.red.shade400, size: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: _savedTreks.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
