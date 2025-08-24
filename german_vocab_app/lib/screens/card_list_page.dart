import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/card.dart';

class CardListPage extends StatefulWidget {
  const CardListPage({super.key});

  @override
  State<CardListPage> createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  List<VocabCard> cards = [];

  Future<void> _fetch() async {
    final res = await http.get(Uri.parse('${dotenv.env['API_BASE']}/cards'));
    final data = jsonDecode(res.body) as List;
    setState(() {
      cards = data.map((e) => VocabCard.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/add').then((_) => _fetch()),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (ctx, i) {
          final c = cards[i];
          return ListTile(
            leading: Image.memory(base64Decode(c.imageBase64)),
            title: Text('${c.germanWord} → ${c.englishTranslation}'),
            subtitle: Text(c.usageExample),
          );
        },
      ),
    );
  }
}
