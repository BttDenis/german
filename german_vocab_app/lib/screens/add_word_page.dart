import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AddWordPage extends StatefulWidget {
  const AddWordPage({super.key});

  @override
  State<AddWordPage> createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  final _controller = TextEditingController();
  bool _loading = false;

  Future<void> _submit() async {
    final word = _controller.text.trim();
    if (word.isEmpty) return;
    setState(() => _loading = true);
    await http.post(
      Uri.parse('${dotenv.env['API_BASE']}/cards'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'german_word': word}),
    );
    setState(() => _loading = false);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Word')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _controller),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _submit,
              child: const Text('Generate'),
            ),
          ],
        ),
      ),
    );
  }
}
