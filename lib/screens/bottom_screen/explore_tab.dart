import 'package:flutter/material.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Explore")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Discover Treks",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            const _ExploreCard(
              title: "Easy Treks",
              subtitle: "Short routes for beginners",
              icon: Icons.directions_walk,
            ),
            const SizedBox(height: 12),
            const _ExploreCard(
              title: "Popular Routes",
              subtitle: "Most visited trails in Nepal",
              icon: Icons.local_fire_department_outlined,
            ),
            const SizedBox(height: 12),
            const _ExploreCard(
              title: "High Altitude",
              subtitle: "For experienced trekkers",
              icon: Icons.terrain,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _ExploreCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon, size: 18)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
