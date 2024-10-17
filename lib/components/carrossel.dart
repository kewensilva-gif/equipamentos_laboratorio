import 'package:flutter/material.dart';
import 'package:equipamentos_laboratorios/components/equipamento.dart';

class Carrossel extends StatefulWidget {
  final List<dynamic> equipaments; // Lista de equipamentos
  final String httpUrl;
  const Carrossel({super.key, required this.equipaments, required this.httpUrl});

  @override
  CarrosselState createState() => CarrosselState();
}

class CarrosselState extends State<Carrossel> {
  final PageController _controller = PageController(); // Controlador do PageView

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PageView(
          controller: _controller, // Controlador do PageView
          children: widget.equipaments.isNotEmpty
              ? widget.equipaments.map((equipament) {
                  return Equipamento(
                    id: equipament.id,
                    title: equipament.name,
                    description: equipament.description,
                    imageUrl: "${widget.httpUrl}/storage/${equipament.image}",
                  );
                }).toList()
              : [
                  const Center(
                    child: Text('Nenhum equipamento disponível'),
                  ),
                ],
        ),
        // Botões de navegação
        Positioned(
          left: 16,
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5), // Fundo semitransparente
            radius: 24,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white), // Ícone branco
              onPressed: () {
                _controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ),
        Positioned(
          right: 16, // Posiciona o botão na direita
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5), // Fundo semitransparente
            radius: 24, // Tamanho do círculo
            child: IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.white), // Ícone branco
              onPressed: () {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
