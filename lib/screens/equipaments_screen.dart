import 'package:flutter/material.dart';
import 'package:equipamentos_laboratorios/components/carousel.dart';
import '../models/equipament_model.dart';
import '../services/api_service.dart';

class EquipamentsScreen extends StatefulWidget {
  const EquipamentsScreen({super.key});

  @override
  _EquipamentsScreenState createState() => _EquipamentsScreenState();
}

class _EquipamentsScreenState extends State<EquipamentsScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Equipament>> _equipamentsFuture;

  @override
  void initState() {
    super.initState();
    _loadEquipaments(); // Carrega os equipamentos inicialmente
  }

  // Função para carregar os equipamentos
  void _loadEquipaments() {
    setState(() {
      _equipamentsFuture = _apiService.fetchEquipaments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipamentos'),
        actions: [ 
          FloatingActionButton( // Botão para linkar a página de criação
            onPressed: () async {
              // Aguarda o resultado da página de criação
              final result = await Navigator.pushNamed(context, '/create');
              if (result == true) {
                // Se um equipamento foi adicionado, recarrega a lista
                _loadEquipaments();
              }
            },
            backgroundColor: Colors.blue[900],
            foregroundColor: Colors.white,
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.deepPurple,
                width: 0.0,
              ),
            ),
            tooltip: 'Novo Equipamento',
            child: const Icon(Icons.add, size: 30.0),
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
