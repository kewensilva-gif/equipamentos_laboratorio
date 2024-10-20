import 'package:equipamentos_laboratorios/screens/show_equipament_screen.dart';
import 'package:flutter/material.dart';

class Equipamento extends StatelessWidget {
  const Equipamento({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  final int id;
  final String title;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Ação ao clicar no card
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalheEquipamento(id: id),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Limitando a altura da imagem para no máximo 300 pixels
            SizedBox(
              width: double.infinity,
              height: 300, // Altura máxima de 300 pixels
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover, // Ajusta a imagem mantendo a proporção
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
