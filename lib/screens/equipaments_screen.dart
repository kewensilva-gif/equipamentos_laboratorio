// lib/screens/equipament_screen.dart

import 'package:flutter/material.dart';
import 'package:equipamentos_laboratorios/components/carrossel.dart';
import '../models/equipament_model.dart';
import '../services/api_service.dart';

class EquipamentsScreen extends StatefulWidget {
  const EquipamentsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EquipamentsScreenState createState() => _EquipamentsScreenState();
}

class _EquipamentsScreenState extends State<EquipamentsScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Equipament>> _equipamentsFuture;

  @override
  void initState() {
    super.initState();
    _equipamentsFuture = _apiService.fetchEquipaments(); // Chama o método para obter os equipamentos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipamentos'),
        actions: [ 
          FloatingActionButton( // Botão para linkar a página de criação
            onPressed: () {
              Navigator.pushNamed(context, '/create');
            },
            child: const Icon(Icons.add, size: 20.0),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 0.0,
              ),
            ),
            tooltip: 'Novo Equipamento',
          ),

        ],
      ),
      body: FutureBuilder<List<Equipament>>(
        future: _equipamentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum equipamento encontrado.'));
          }

          final equipaments = snapshot.data!;
          return Carrossel(equipaments: equipaments, httpUrl: _apiService.httpUrl);
        },
      ),
    );
  }
}
