import 'package:flutter/material.dart';
import 'package:tic_tac_toe/home/view/home_page.dart';

const Color red = Color(0xffFD4040);
const Color yellow = Color(0xffFEB903);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // brightness: Brightness.dark,
        backgroundColor: red,
        scaffoldBackgroundColor: red,
        fontFamily: 'Bungee',
        colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: yellow,
              brightness: Brightness.dark,
            ),
      ),
      home: const HomePage(),
    );
  }
}
