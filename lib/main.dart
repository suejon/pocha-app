import 'package:flutter/material.dart';
import 'package:new_mac_test/screens/map_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://chjzbaxswixtqvtytkyz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNoanpiYXhzd2l4dHF2dHl0a3l6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA4ODUyOTYsImV4cCI6MjAxNjQ2MTI5Nn0.lfuhHjP4-G1wexxmzo6LLIjRbGxQ--QHWnr3ubAzRx0',
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
