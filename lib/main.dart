import 'package:flutter/material.dart';
import 'package:equipamentos_laboratorios/screens/equipaments_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equipamentos de Laboratórios',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        // '/': (context) => const Home(title: 'Flutter Demo Home Page'),
        // '/second': (context) => const SecondPage(title: 'page2'),
        '/': (context) => EquipamentsScreen(),
      },
    );
  }
}