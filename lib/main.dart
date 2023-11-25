import 'package:flutter/material.dart';
import 'package:new_mac_test/screens/map_screen.dart';

void main() {
  await Supabase.initialize(
    url: 'https://chjzbaxswixtqvtytkyz.supabase.co',
    anonKey: 'public-anon-key',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MapScreen(),
    );
  }
}
