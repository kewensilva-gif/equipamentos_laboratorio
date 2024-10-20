import 'package:equipamentos_laboratorios/components/formCreateEquipament.dart';
import 'package:flutter/material.dart';

class CreateEquipament extends StatelessWidget {
  const CreateEquipament({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar equipamento'),
      ),
      body: const FormCreateEquipament(),
    );
  }
}

