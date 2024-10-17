import 'package:equipamentos_laboratorios/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

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

class FormCreateEquipament extends StatefulWidget {
  const FormCreateEquipament({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormCreateEquipamentState createState() => _FormCreateEquipamentState();
}

class _FormCreateEquipamentState extends State<FormCreateEquipament> {
  final ApiService _apiService = ApiService();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>(); // Chave para validar o formulário
  String _name = '';
  String _description = '';

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // salva o estado do formulário

      final url = Uri.parse(_apiService.httpUrl);
      final request = http.MultipartRequest('POST', url); // form multipart pq vai enviar arquivo

      // corpo da requisição
      request.fields['name'] = _name;
      request.fields['description'] = _description;
      if (_selectedImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          _selectedImage!.path,
        ));
      }

      final response = await request.send(); // envio
      
      if (response.statusCode == 200) {

       Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Equipamento enviado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Falha ao enviar o equipamento.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Associar a chave do formulário
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Digite o nome',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um nome';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Digite a descrição',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma descrição';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text('Selecione uma imagem'),
              ),
              _selectedImage != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: Image.file(
                        _selectedImage!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: Text('Nenhuma imagem selecionada'),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Selecionar Imagem'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(0, 34, 4, 68),
                  ),
                  onPressed: _submitForm, // Submete o formulário
                  child: const Text('Enviar Equipamento'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
