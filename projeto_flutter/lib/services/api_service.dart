import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/parlamentar.dart'; // Atualize o caminho conforme necessário
import '../models/parlamentar_detalhes.dart'; // Atualize o caminho conforme necessário

class ApiService {
  static const String baseUrl = 'http://192.168.100.55:3000/api/parlamentares';

  // Método para buscar todos os parlamentares para a tela inicial
  static Future<List<Parlamentar>> fetchParlamentares() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // A estrutura da resposta pode ser diferente, ajuste conforme necessário
      final List<dynamic> parlamentaresJson = jsonData['parlamentares'];
      return parlamentaresJson.map((json) => Parlamentar.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load parlamentares');
    }
  }

  // Método para buscar detalhes de um parlamentar específico
  static Future<ParlamentarDetalhes> fetchParlamentarDetalhes(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ParlamentarDetalhes.fromJson(jsonData);
    } else {
      throw Exception('Failed to load parlamentar detalhes');
    }
  }
}
