import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
  const SavedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Saved Treks",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  _SavedTrekTile(
                    name: "Annapurna Base Camp",
                    location: "Kaski",
                  ),
                  SizedBox(height: 10),
                  _SavedTrekTile(
                    name: "Everest View Trail",
                    location: "Solukhumbu",
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

class _SavedTrekTile extends StatelessWidget {
  final String name;
  final String location;

  const _SavedTrekTile({required this.name, required this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.bookmark),
        title: Text(name),
        subtitle: Text(location),
        trailing: const Icon(Icons.more_vert),
        onTap: () {},
      ),
    );
  }
}
