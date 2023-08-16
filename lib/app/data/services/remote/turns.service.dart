import 'dart:convert';

import 'package:datamex_master_app/app/data/constants/constants.dart';
import 'package:datamex_master_app/app/domain/models/turns.dart';
import 'package:http/http.dart' as http;

class TurnsService {
  TurnsService();
  //final _baseUrl = AppConstants.baseUrl;

  Future<List<TurnsModel>> getTurns() async {
    try {
      var url = Uri.parse('${AppConstants.baseUrl}/turns');

      final response = await http.get(url);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> turnsJson = json.decode(response.body);
        final List<TurnsModel> turnsResponse =
            turnsJson.map((json) => TurnsModel.fromMap(json)).toList();
        return turnsResponse;
      } else {
        throw Exception('Failed to fetch turns');
      }
    } catch (e) {
      // Aquí mostramos el error en la consola
      print('Error fetching turns: $e');

      // Manejamos el error de manera adecuada, por ejemplo, podemos relanzar una excepción con un mensaje más claro
      throw Exception('Error fetching turns: $e');
    }
  }

  addTurn(String name) async {
    var url = Uri.parse('${AppConstants.baseUrl}/turns');
    Map<String, dynamic> data = {
      'name': name,
    };

    try {
      final response = await http.post(url, body: data);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // La solicitud fue exitosa
        print('Datos enviados con éxito');
      } else {
        // La solicitud falló
        print('Error al enviar los datos: ${response.statusCode}');
      }
    } catch (e) {
      // Ocurrió un error al realizar la solicitud
      print('Error de red: $e');
    }
  }

  Future<Map<String, dynamic>> delete(String id) async {
    var url = Uri.parse('${AppConstants.baseUrl}/turns/$id');
    print(id);
    try {
      final response = await http.delete(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        // La solicitud falló
        print('Error al enviar los datos: ${response.statusCode}');
        print(json.decode(response.body));
        throw Exception('Failed to fetch turns');
      }
    } catch (e) {
      // Ocurrió un error al realizar la solicitud
      print('Error de red: $e');
      return {
        'success': false,
        'message': 'Error de conexión',
      };
    }
  }
}
