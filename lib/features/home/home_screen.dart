import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home 🎉'), centerTitle: true),
      body: const _HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addFunItem(context),
        child: const Icon(Icons.cake),
      ),
    );
  }
}

void _addFunItem(BuildContext context) {
  // Delegate to the body via an inherited context lookup
  final state = context.findAncestorStateOfType<_HomeBodyState>();
  state?.addRandomItem();
}

class _HomeBody extends StatefulWidget {
  const _HomeBody({Key? key}) : super(key: key);

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  final List<String> items = List.generate(20, (i) => 'Item ${i + 1}');
  final Random _random = Random();

  static const List<String> _emojis = [
    '🎈',
    '🎉',
    '✨',
    '🦄',
    '🍩',
    '🍕',
    '🐱',
    '🚀',
    '🌈',
    '😺',
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final title = items[index];
          final emoji = _emojis[index % _emojis.length];
          return Card(
            child: ListTile(
              title: Text(title),
              leading: Hero(
                tag: title,
                child: CircleAvatar(
                  backgroundColor: Colors
                      .primaries[index % Colors.primaries.length]
                      .withOpacity(0.6),
                  child: Text(emoji, style: const TextStyle(fontSize: 20)),
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => _openDetail(context, title, emoji),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      items.shuffle(_random);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Shuffled — new surprises!')));
  }

  void addRandomItem() {
    final emoji = _emojis[_random.nextInt(_emojis.length)];
    setState(() {
      items.insert(0, 'Fun ${DateTime.now().millisecondsSinceEpoch % 1000}');
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Added something fun $emoji')));
  }

  void _openDetail(BuildContext context, String title, String emoji) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: title,
                  child: CircleAvatar(
                    radius: 64,
                    child: Text(emoji, style: const TextStyle(fontSize: 48)),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Details for $title',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(content: Text('🎉 Celebrate $title!')),
                    );
                  },
                  icon: const Text('🎉'),
                  label: const Text('Celebrate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
