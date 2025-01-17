import 'package:equipamentos_laboratorios/screens/create_equipament_screen.dart';
import 'package:equipamentos_laboratorios/screens/show_equipament_screen.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const EquipamentsScreen(),
        '/create': (context) => const CreateEquipament(title: 'Criação de equipamento'),
        '/detalhe': (context) => const DetalheEquipamento(id: 1),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}