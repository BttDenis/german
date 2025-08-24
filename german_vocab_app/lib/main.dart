import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/add_word_page.dart';
import 'screens/card_list_page.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'German Vocab',
      routes: {
        '/': (_) => const CardListPage(),
        '/add': (_) => const AddWordPage(),
      },
    );
  }
}
