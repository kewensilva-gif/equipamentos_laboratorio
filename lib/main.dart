import 'package:equipamentos_laboratorios/screens/create_equipament_screen.dart';
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
        '/create': (context) => const CreateEquipament(title: 'Criação de equipamento'),
        '/': (context) => const EquipamentsScreen(),
        // '/': (context) => const EquipamentsScreen(),
      },
    );
  }
}