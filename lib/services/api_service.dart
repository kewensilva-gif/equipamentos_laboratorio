import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/equipament_model.dart';

class ApiService {
  final String httpUrl = "https://2e9a-2804-4ff4-20b-3000-348f-416e-c2a5-7308.ngrok-free.app"; 

  // ApiService() {
  // }

  Future<List<Equipament>> fetchEquipaments() async {
    final response = await http.get(
      Uri.parse('$httpUrl/api/equipaments'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': '',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true', // ignora a página inicial do ngrok
      },
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
}