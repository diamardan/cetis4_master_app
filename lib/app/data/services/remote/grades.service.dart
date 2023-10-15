import 'dart:convert';

import 'package:cetis4_master_app/app/data/constants/constants.dart';
import 'package:cetis4_master_app/app/domain/models/grades.dart';
import 'package:http/http.dart' as http;

class GradesService {
  GradesService();
  //final _baseUrl = AppConstants.baseUrl;

  Future<List<GradesModel>> getGrades() async {
    try {
      var url = Uri.parse('${AppConstants.baseUrl}/grades');

      final response = await http.get(url);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> gradesJson = json.decode(response.body);
        final List<GradesModel> gradesResponse =
            gradesJson.map((json) => GradesModel.fromMap(json)).toList();
        return gradesResponse;
      } else {
        throw Exception('Failed to fetch grades');
      }
    } catch (e) {
      // Aquí mostramos el error en la consola
      print('Error fetching grades: $e');

      // Manejamos el error de manera adecuada, por ejemplo, podemos relanzar una excepción con un mensaje más claro
      throw Exception('Error fetching grades: $e');
    }
  }

  addGrade(String name) async {
    var url = Uri.parse('${AppConstants.baseUrl}/grades');
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
    var url = Uri.parse('${AppConstants.baseUrl}/grades/$id');
    print(id);
    try {
      final response = await http.delete(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        // La solicitud falló
        print('Error al enviar los datos: ${response.statusCode}');
        print(json.decode(response.body));
        throw Exception('Failed to fetch grades');
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
