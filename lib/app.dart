import 'package:ai_luminance_flutter/screens/start_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Luminance',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => StartScreen(),
      },
    );
  }
}
