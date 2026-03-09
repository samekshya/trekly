import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/treks/presentation/viewmodels/trek_viewmodel.dart';

class ExploreTab extends ConsumerStatefulWidget {
  const ExploreTab({super.key});

  @override
  ConsumerState<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends ConsumerState<ExploreTab> {
  final _searchController = TextEditingController();
  String _selectedDifficulty = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trekState = ref.watch(trekViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: Column(
        children: [
          // search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search treks...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) {
                ref.read(trekViewModelProvider.notifier).loadTreks(
                      search: value,
                      difficulty: _selectedDifficulty,
                    );
              },
            ),
          ),

          // difficulty filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: ['All', 'Easy', 'Moderate', 'Hard'].map((d) {
                final isSelected = _selectedDifficulty == (d == 'All' ? '' : d);
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(d),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        _selectedDifficulty = d == 'All' ? '' : d;
                      });
                      ref.read(trekViewModelProvider.notifier).loadTreks(
                            search: _searchController.text,
                            difficulty: _selectedDifficulty,
                          );
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 8),

          // trek list
          Expanded(
            child: trekState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : trekState.error != null
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline,
                                size: 48, color: Colors.red),
                            const SizedBox(height: 8),
                            Text('Error: ${trekState.error}'),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () => ref
                                  .read(trekViewModelProvider.notifier)
                                  .loadTreks(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : trekState.treks.isEmpty
                        ? const Center(child: Text('No treks found'))
                        : ListView.builder(
                            padding: const EdgeInsets.all(12),
                            itemCount: trekState.treks.length,
                            itemBuilder: (context, index) {
                              final trek = trekState.treks[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                      trek.name[0],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  title: Text(trek.name),
                                  subtitle: Text(trek.location),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        trek.difficulty,
                                        style: TextStyle(
                                          color: trek.difficulty == 'Easy'
                                              ? Colors.green
                                              : trek.difficulty == 'Moderate'
                                                  ? Colors.orange
                                                  : Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text('${trek.duration} days',
                                          style: const TextStyle(fontSize: 11)),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/trek-detail',
                                      arguments: trek.id,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
