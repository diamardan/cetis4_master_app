import 'dart:convert';
import 'dart:io';

import 'package:datamex_master_app/app/data/constants/constants.dart';
import 'package:datamex_master_app/app/domain/models/registration.dart';
import 'package:datamex_master_app/app/domain/models/registration.form.dart';
import 'package:datamex_master_app/app/presentation/utils/net_util.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class RegistrationsService {
  RegistrationsService();
  //final _baseUrl = AppConstants.baseUrl;

  Future<List<RegistrationModel>> getRegistrations() async {
    try {
      var url = Uri.parse('${AppConstants.baseUrl}/registrations');

      final response = await http.get(url);
      print(response.statusCode);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.body);
        final List<dynamic> registrationsJson = json.decode(response.body);
        print(registrationsJson);

        final List<RegistrationModel> registrationsResponse = registrationsJson
            .map((json) => RegistrationModel.fromMap(json))
            .toList();
        print(registrationsResponse);
        return registrationsResponse;
      } else {
        throw Exception('Failed to fetch registrations');
      }
    } catch (e) {
      // Aquí mostramos el error en la consola
      print('Error fetching registrations: $e');

      // Manejamos el error de manera adecuada, por ejemplo, podemos relanzar una excepción con un mensaje más claro
      throw Exception('Error fetching registrations: $e');
    }
  }

  Future<Map<String, dynamic>> addRegistration(
      RegistrationFormData data, File? foto, File? voucher, firma) async {
    String url = '${AppConstants.baseUrl}/registrations';
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

    if (foto != null) {
      final fotoMime = mime(foto.path)!.split('/');

      request.files.add(await http.MultipartFile.fromPath(
        'student_photo',
        foto.path, //foto.path,
        contentType: MediaType(fotoMime[0], fotoMime[1]),
        filename: 'FOTO',
      ));
    }
    if (voucher != null) {
      /* final compressedVoucher =
          await ImageUtils.compressAndRotateImage(voucher, 80);
      // Crear un archivo temporal con los bytes comprimidos
      final compressedVoucherFile = File('${voucher.path}_compressed.jpg');
      await compressedVoucherFile.writeAsBytes(compressedVoucher); */
      final voucherMime = mime(voucher.path)!.split('/');
      request.files.add(await http.MultipartFile.fromPath(
        'student_voucher',
        voucher.path,
        contentType: MediaType(voucherMime[0], voucherMime[1]),
        filename: 'VOUCHER',
      ));
    }

    if (firma != null) {
      final dir = await getTemporaryDirectory();
      final imgFirma = File(path.join(dir.path, 'firma.jpg'));
      await imgFirma.writeAsBytes(
        firma.buffer.asUint8List(firma.offsetInBytes, firma.lengthInBytes),
      );
      request.files.add(await http.MultipartFile.fromPath(
        'student_signature',
        imgFirma.path,
        contentType: MediaType('image', 'jpg'),
        filename: 'student_signature',
      ));
    } else {
      request.fields['student_signature_path'] = data.student_signature_path!;
    }

    try {
      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      final responseJson = json.decode(responseString);
      final message = responseJson['message'];

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // La solicitud fue exitosa
        return {'success': true, 'responseJson': responseJson};
      } else {
        // La solicitud falló
        final errorMessage = responseJson != null
            ? responseJson['message'] ?? 'Error desconocido'
            : 'Error desconocido';
        return {'success': false, 'error': errorMessage};
      }
    } on SocketException {
      throw FetchDataException('No internet Connection');
    }
  }

  Future<Map<String, dynamic>> delete(String id) async {
    var url = Uri.parse('${AppConstants.baseUrl}/registrations/$id');
    print(id);
    try {
      final response = await http.delete(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        // La solicitud falló
        print('Error al enviar los datos: ${response.statusCode}');
        print(json.decode(response.body));
        throw Exception('Failed to fetch registrations');
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
