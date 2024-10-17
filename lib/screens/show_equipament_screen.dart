import 'package:equipamentos_laboratorios/models/equipament_model.dart';
import 'package:equipamentos_laboratorios/services/api_service.dart';
import 'package:flutter/material.dart';
class DetalheEquipamento extends StatefulWidget {
  const DetalheEquipamento({super.key, required this.id});
  final int id;
  @override
  // ignore: library_private_types_in_public_api
  DetalheEquipamentoState createState() => DetalheEquipamentoState();
}


class DetalheEquipamentoState extends State<DetalheEquipamento>  {
  final ApiService _apiService = ApiService();
  late Future<Equipament> _equipamentFuture;
  @override
  void initState() {
    super.initState();
    _equipamentFuture = _apiService.showEquipament(widget.id); // Chama o método para obter os equipamentos
  }
  @override
  Widget build(BuildContext context) {
    /* final String id = ModalRoute.of(context)!.settings.arguments as String; */

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Equipamento')),
      body: FutureBuilder<Equipament>(
        future: _equipamentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Nenhum equipamento encontrado.'));
          }

          final equipament = snapshot.data!;
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300, // Altura máxima de 300 pixels
                    child: Image.network(
                      "${_apiService.httpUrl}/storage/${equipament.image}",
                      fit: BoxFit.cover, // Ajusta a imagem mantendo a proporção
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(equipament.name),
                    subtitle: Text(equipament.description),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
