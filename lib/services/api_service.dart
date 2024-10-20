import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/equipament_model.dart';

class ApiService {
  final String httpUrl = "https://e085-2804-4ff4-20b-3000-5031-2966-b7-93fb.ngrok-free.app"; 
  final headers = { 
    'X-Requested-With': 'XMLHttpRequest',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'ngrok-skip-browser-warning': 'true'
  };

  Future<List<Equipament>> fetchEquipaments() async {
    final response = await http.get(
      Uri.parse('$httpUrl/api/equipaments'),
      headers: headers
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      // converte os dados json para uma lista dynamic
      final List<dynamic> equipamentList = jsonData['data'];
      
      // mapeia cada item da lista para um objeto Equipament
      return equipamentList.map((json) => Equipament.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar dados: ${response.statusCode}');
    }
  }

  Future<Equipament> showEquipament(int id) async {
    final response = await http.get(
      Uri.parse('$httpUrl/api/equipaments/$id'),
      headers: headers
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return Equipament.fromJson(jsonData);
    } else {
      throw Exception('Falha ao carregar dados: ${response.statusCode}');
    }
  }
  
  Future<int> postEquipament(String name, String description, File? image) async {
      final url = Uri.parse("$httpUrl/api/equipaments");
      final request = http.MultipartRequest('POST', url); // form multipart pq vai enviar arquivo

      // corpo da requisição
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image!.path,
      ));

      final response = await request.send(); // envio
      
      return response.statusCode;
  }
}