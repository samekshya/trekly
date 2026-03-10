import 'package:flutter/material.dart';

class TrekkingEssentialsScreen extends StatefulWidget {
  const TrekkingEssentialsScreen({super.key});

  @override
  State<TrekkingEssentialsScreen> createState() =>
      _TrekkingEssentialsScreenState();
}

class _TrekkingEssentialsScreenState extends State<TrekkingEssentialsScreen> {
  final Map<String, bool> _checked = {};

  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Clothing & Footwear',
      'icon': Icons.checkroom,
      'color': const Color(0xFF1565C0),
      'bg': const Color(0xFFE3F2FD),
      'items': [
        'Waterproof trekking boots',
        'Wool or synthetic socks (3 pairs)',
        'Moisture-wicking base layer',
        'Fleece mid-layer jacket',
        'Waterproof outer shell jacket',
        'Trekking pants (convertible)',
        'Warm hat and gloves',
        'Sun hat / cap',
        'Gaiters (for snow treks)',
        'Camp sandals or flip flops',
      ],
    },
    {
      'title': 'Backpack & Gear',
      'icon': Icons.backpack,
      'color': const Color(0xFF2E7D32),
      'bg': const Color(0xFFE8F5E9),
      'items': [
        'Trekking backpack (40–60L)',
        'Daypack (20–25L)',
        'Waterproof pack cover',
        'Trekking poles (pair)',
        'Sleeping bag (rated -10°C)',
        'Sleeping bag liner',
        'Headlamp + extra batteries',
        'Dry bags or zip-lock bags',
        'Lightweight camp towel',
        'Stuff sacks for organisation',
      ],
    },
    {
      'title': 'Navigation & Safety',
      'icon': Icons.explore,
      'color': const Color(0xFFE65100),
      'bg': const Color(0xFFFFF3E0),
      'items': [
        'Detailed trail map',
        'Compass',
        'Whistle (emergency signalling)',
        'Personal locator beacon (PLB)',
        'Emergency bivouac bag',
        'Fully charged power bank',
        'Extra phone battery',
        'Trail guidebook',
        'Permits (TIMS card, national park)',
        'Emergency contact list',
      ],
    },
    {
      'title': 'First Aid & Health',
      'icon': Icons.medical_services,
      'color': const Color(0xFFC62828),
      'bg': const Color(0xFFFFEBEE),
      'items': [
        'First aid kit (bandages, antiseptic)',
        'Altitude sickness pills (Diamox)',
        'Blister treatment kit',
        'Pain relievers (ibuprofen)',
        'Rehydration salts (ORS)',
        'Antihistamines',
        'Diarrhea medication',
        'Sunscreen SPF 50+',
        'Lip balm with SPF',
        'Insect repellent',
      ],
    },
    {
      'title': 'Food & Water',
      'icon': Icons.water_drop,
      'color': const Color(0xFF00695C),
      'bg': const Color(0xFFE0F2F1),
      'items': [
        'Water purification tablets',
        'Water filter (LifeStraw etc.)',
        'Insulated water bottle (1L)',
        'Hydration bladder (2L)',
        'High-energy snacks (nuts, bars)',
        'Instant noodles / backup meals',
        'Electrolyte powder',
        'Thermos flask for hot drinks',
        'Lightweight stove + fuel',
        'Spork / lightweight utensils',
      ],
    },
    {
      'title': 'Documents & Money',
      'icon': Icons.badge,
      'color': const Color(0xFF6A1B9A),
      'bg': const Color(0xFFF3E5F5),
      'items': [
        'Passport (original)',
        'Trekking permit / TIMS card',
        'Travel insurance documents',
        'Emergency cash (Nepali Rupees)',
        'ATM card (backup)',
        'Hotel / teahouse reservations',
        'Flight tickets (printed copy)',
        ' 2 passport-size photos',
        'Embassy contact details',
        'Vaccination certificate',
      ],
    },
  ];

  int get _totalItems =>
      _categories.fold(0, (sum, c) => sum + (c['items'] as List).length);

  int get _checkedCount => _checked.values.where((v) => v).length;

  @override
  Widget build(BuildContext context) {
    final progress = _totalItems == 0 ? 0.0 : _checkedCount / _totalItems;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            backgroundColor: const Color(0xFF00695C),
            foregroundColor: Colors.white,
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
                      width: 140,
                      height: 140,
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
                            'Trekking Essentials',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Your complete packing checklist',
                            style:
                                TextStyle(color: Colors.white60, fontSize: 13),
                          ),
                          const SizedBox(height: 12),
                          // progress bar
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                    minHeight: 6,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '$_checkedCount / $_totalItems',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Reset button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _checkedCount == _totalItems && _totalItems > 0
                        ? '🎉 All packed! Ready to trek!'
                        : '${_totalItems - _checkedCount} items remaining',
                    style: TextStyle(
                      color: _checkedCount == _totalItems
                          ? const Color(0xFF00695C)
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _checked.clear()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Reset All',
                        style: TextStyle(
                          color: Colors.red.shade400,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Categories
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = _categories[index];
                  final items = cat['items'] as List<String>;
                  final color = cat['color'] as Color;
                  final bg = cat['bg'] as Color;
                  final icon = cat['icon'] as IconData;

                  final catChecked =
                      items.where((i) => _checked[i] == true).length;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Category header
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(9),
                                decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(icon, color: color, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  cat['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: catChecked == items.length
                                      ? const Color(0xFF00695C)
                                      : bg,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '$catChecked/${items.length}',
                                  style: TextStyle(
                                    color: catChecked == items.length
                                        ? Colors.white
                                        : color,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Divider(
                            height: 1,
                            color: Colors.grey.shade100,
                            indent: 16,
                            endIndent: 16),

                        // Items
                        ...items.map((item) {
                          final isChecked = _checked[item] == true;
                          return InkWell(
                            onTap: () =>
                                setState(() => _checked[item] = !isChecked),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 11),
                              child: Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: isChecked
                                          ? const Color(0xFF00695C)
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: isChecked
                                            ? const Color(0xFF00695C)
                                            : Colors.grey.shade300,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: isChecked
                                        ? const Icon(Icons.check,
                                            color: Colors.white, size: 14)
                                        : null,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isChecked
                                            ? Colors.grey
                                            : Colors.black87,
                                        decoration: isChecked
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 4),
                      ],
                    ),
                  );
                },
                childCount: _categories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
