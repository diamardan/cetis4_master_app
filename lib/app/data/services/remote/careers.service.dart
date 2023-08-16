import 'dart:convert';

import 'package:datamex_master_app/app/data/constants/constants.dart';
import 'package:datamex_master_app/app/domain/models/careers.dart';
import 'package:http/http.dart' as http;

class CareersService {
  CareersService();
  //final _baseUrl = AppConstants.baseUrl;

  Future<List<CareerModel>> getCareers() async {
    try {
      var url = Uri.parse('${AppConstants.baseUrl}/careers');

      final response = await http.get(url);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> careersJson = json.decode(response.body);
        final List<CareerModel> careersResponse =
            careersJson.map((json) => CareerModel.fromMap(json)).toList();
        return careersResponse;
      } else {
        throw Exception('Failed to fetch careers');
      }
    } catch (e) {
      // Aquí mostramos el error en la consola
      print('Error fetching careers: $e');

      // Manejamos el error de manera adecuada, por ejemplo, podemos relanzar una excepción con un mensaje más claro
      throw Exception('Error fetching careers: $e');
    }
  }

  addCareer(String name) async {
    var url = Uri.parse('${AppConstants.baseUrl}/careers');
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
    var url = Uri.parse('${AppConstants.baseUrl}/careers/$id');
    print(id);
    try {
      final response = await http.delete(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        // La solicitud falló
        print('Error al enviar los datos: ${response.statusCode}');
        print(json.decode(response.body));
        throw Exception('Failed to fetch careers');
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
