import 'package:flutter/material.dart';
import 'package:made_with_serverpod/made_with_serverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Made with Serverpod Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MadeWithServerpod(
        // child: Center(
        child: AnimatedServerpodLogo(
          brightness: Brightness.light,
          animate: true,
        ),
      ),
      // ),
    );
  }
}
