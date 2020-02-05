import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/GameScreen.dart';
import 'providers/GameStateProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (_) => GameStateProvider(),
          child: GameScreen()),
    );
  }
}


