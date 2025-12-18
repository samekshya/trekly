import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trekly"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Text(
              "Good evening, Trekker!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            Text(
              "Plan your next trek in Nepal.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Quick stats
            Row(
              children: const [
                Expanded(
                  child: _StatCard(
                    title: "Total Treks",
                    value: "12",
                    icon: Icons.hiking,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: "Saved",
                    value: "3",
                    icon: Icons.bookmark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Section: Recommended
            Text(
              "Recommended Treks",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),

            const _TrekCard(
              name: "Poon Hill",
              location: "Ghorepani, Myagdi",
              duration: "2–3 days",
            ),
            const SizedBox(height: 12),
            const _TrekCard(
              name: "Langtang Valley",
              location: "Rasuwa",
              duration: "6–8 days",
            ),
            const SizedBox(height: 12),
            const _TrekCard(
              name: "Mardi Himal",
              location: "Kaski",
              duration: "4–6 days",
            ),
            const SizedBox(height: 20),

            // Section: Tips
            Text("Quick Tips", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            const _TipTile(text: "Carry enough water and a rain jacket."),
            const _TipTile(
              text: "Start early to avoid afternoon weather changes.",
            ),
            const _TipTile(text: "Inform someone before you begin your hike."),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(radius: 18, child: Icon(icon, size: 18)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 4),
                Text(value, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TrekCard extends StatelessWidget {
  final String name;
  final String location;
  final String duration;

  const _TrekCard({
    required this.name,
    required this.location,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black12,
              ),
              child: const Icon(Icons.terrain),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(location, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            Text(duration, style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}

class _TipTile extends StatelessWidget {
  final String text;

  const _TipTile({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
