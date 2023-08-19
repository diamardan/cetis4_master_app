import 'dart:convert';
import 'dart:io';

import 'package:datamex_master_app/app/data/constants/constants.dart';
import 'package:datamex_master_app/app/domain/models/preregistration.dart';
import 'package:datamex_master_app/app/domain/models/preregistration.form.dart';
import 'package:datamex_master_app/app/presentation/utils/net_util.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class PreregistrationsService {
  PreregistrationsService();
  //final _baseUrl = AppConstants.baseUrl;

// Simula la función de búsqueda en el servidor
  Future<List<PreregistrationModel>> searchByCurp(String query) async {
    print(query);
    var url = Uri.parse('${AppConstants.baseUrl}/preregistrations/verify-curp');

    final response = await http.post(url, body: {'curp': query});
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse['data']);
      PreregistrationModel preregistration =
          PreregistrationModel.fromMap(jsonResponse['data']);
      return [preregistration];
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  Future<List<Map<String, dynamic>>> searchByApellidos(String query) async {
    print(query);
    var url = Uri.parse(
        '${AppConstants.baseUrl}/preregistrations/search?surnames=$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);

      List<Map<String, dynamic>> suggestions =
          jsonResponse.map<Map<String, dynamic>>((item) {
        print(
            'jsdnkajdnkajsdnkajsdnkasjdnaksjdnkasdjansdkkajsdnkajsnd 🙄🙄🙄🙄🙄🙄🙄🙄🙄🙄🙄🙄🙄');
        print(item);
        return {
          'names': item['names'] as String,
          'surnames': item['surnames'] as String,
          'curp': item['curp'],
          'email': item['email'],
          'cellphone': item['cellphone'] as String,
          'registration_number': item['registration_number'] ?? '',
          'idbio': item['idbio'] ?? '',
          'career': item['career']['id'] as String,
          'grade': item['grade']['id'] as String,
          'group': item['group']['id'] as String,
          'turn': item['turn']['id'] as String,
          'student_signature_path': item['student_signature_path'] ?? '',
          'student_photo_path': item['student_photo_path'] ?? ''
        };
      }).toList();

      return suggestions;
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  Future<List<PreregistrationModel>> getPreregistrations() async {
    try {
      var url = Uri.parse('${AppConstants.baseUrl}/preregistrations');

      final response = await http.get(url);
      print(response.statusCode);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.body);
        final List<dynamic> preregistrationsJson = json.decode(response.body);
        print(preregistrationsJson);
        final List<PreregistrationModel> preregistrationsResponse =
            preregistrationsJson
                .map((json) => PreregistrationModel.fromMap(json))
                .toList();

        print(preregistrationsResponse);
        return preregistrationsResponse;
      } else {
        throw Exception('Failed to fetch preregistrations');
      }
    } catch (e) {
      // Aquí mostramos el error en la consola
      print('Error fetching preregistrations: $e');

      // Manejamos el error de manera adecuada, por ejemplo, podemos relanzar una excepción con un mensaje más claro
      throw Exception('Error fetching preregistrations: $e');
    }
  }

  Future<Map<String, dynamic>> addPreregistration(
      PreregistrationFormData data, firma) async {
    String url = '${AppConstants.baseUrl}/preregistrations';
    final endpoint = Uri.parse(url);

    var request = http.MultipartRequest('POST', endpoint)
      ..fields['names'] = data.names.trim()
      ..fields['surnames'] = data.surnames.trim()
      ..fields['curp'] = data.curp.trim()
      ..fields['registration_number'] = data.registration_number
      ..fields['career'] = data.career
      ..fields['grade'] = data.grade
      ..fields['group'] = data.group
      ..fields['turn'] = data.turn
      ..fields['email'] = data.email
      ..fields['cellphone'] = data.cellphone
      ..fields['registration_type'] = 'APP';

    if (firma != null) {
      final dir = await getTemporaryDirectory();
      await dir.create(recursive: true);
      final imgFirma = File(path.join(dir.path, 'firma.jpg'));
      await imgFirma.writeAsBytes(
          firma.buffer.asUint8List(firma.offsetInBytes, firma.lengthInBytes));
      request.files.add(
          await http.MultipartFile.fromPath('student_signature', imgFirma.path,
              contentType: MediaType('image', 'jpg'),
              /* MediaType(firmaMime[0], firmaMime[1] )*/
              filename: 'student_signature'));
    }

    try {
      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      final responseJson = json.decode(responseString);
      final message = responseJson['message'];
      print(message);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // La solicitud fue exitosa
        print('Datos enviados con éxito');
        return {'code': response.statusCode, 'responseJson': responseJson};
      } else {
        // La solicitud falló
        print('Error al enviar los datos: ${response.statusCode}');
        final errorMessage = responseJson != null
            ? responseJson['message']
            : 'Error desconocido';
        return {'error': errorMessage};
      }
    } on SocketException {
      throw FetchDataException('No internet Connection');
    }

    // Agrega una instrucción de retorno al final de la función
    return {}; // Puedes retornar un valor vacío o cualquier otro valor que tenga sentido en tu aplicación
  }

  Future<Map<String, dynamic>> delete(String id) async {
    var url = Uri.parse('${AppConstants.baseUrl}/preregistrations/$id');
    print(id);
    try {
      final response = await http.delete(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        // La solicitud falló
        print('Error al enviar los datos: ${response.statusCode}');
        print(json.decode(response.body));
        throw Exception('Failed to fetch preregistrations');
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
