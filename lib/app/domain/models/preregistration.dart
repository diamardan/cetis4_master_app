import 'dart:convert';

import 'package:datamex_master_app/app/domain/models/careers.dart';
import 'package:datamex_master_app/app/domain/models/grades.dart';
import 'package:datamex_master_app/app/domain/models/groups.dart';
import 'package:datamex_master_app/app/domain/models/turns.dart';

class PreregistrationModel {
  PreregistrationModel({
    required this.id,
    required this.names,
    required this.surnames,
    required this.curp,
    required this.email,
    required this.cellphone,
    this.idbio,
    required this.registrationType,
    this.registrationNumber,
    required this.studentSignaturePath,
    this.studentPhotoPath,
    this.studentQrPath,
    required this.qr,
    required this.career,
    required this.grade,
    required this.group,
    required this.turn,
    required this.fecha,
    required this.hora,

/*     required this.fecha,
    required this.hora, */
  });

  factory PreregistrationModel.fromJson(String str) =>
      PreregistrationModel.fromMap(json.decode(str));

  factory PreregistrationModel.fromMap(Map<String, dynamic> json) =>
      PreregistrationModel(
        id: json['id'],
        names: json['names'],
        surnames: json['surnames'],
        curp: json['curp'],
        email: json['email'],
        cellphone: json['cellphone'],
        idbio: json['idbio'],
        registrationType: json['registration_type'],
        registrationNumber: json['registration_number'] ?? '',
        studentSignaturePath: json['student_signature_path'] ?? '',
        studentPhotoPath: json['student_photo_path'],
        studentQrPath: json['student_qr_path'] ?? '',
        qr: json['qr'],
        fecha: json['fecha'] ?? '',
        hora: json['hora'] ?? '',
        career: CareerModel.fromMap(json['career']),
        grade: GradesModel.fromMap(json['grade']),
        group: GroupsModel.fromMap(json['group']),
        turn: TurnsModel.fromMap(json['turn']),
      );
  String id;
  String names;
  String surnames;
  String curp;
  String email;
  String cellphone;
  dynamic idbio;
  String registrationType;
  String? registrationNumber;
  String studentSignaturePath;
  dynamic studentPhotoPath;
  dynamic studentQrPath;
  String qr;
  String? fecha;
  String? hora;
  CareerModel career;
  GradesModel grade;
  GroupsModel group;
  TurnsModel turn;

  PreregistrationModel copyWith({
    String? id,
    String? names,
    String? surnames,
    String? curp,
    String? email,
    String? cellphone,
    int? idbio,
    String? registrationType,
    String? registrationNumber,
    dynamic studentSignaturePath,
    dynamic studentPhotoPath,
    dynamic studentQrPath,
    String? qr,
    String? fecha,
    String? hora,
    CareerModel? career,
    GradesModel? grade,
    GroupsModel? group,
    TurnsModel? turn,
  }) =>
      PreregistrationModel(
        id: id ?? this.id,
        names: names ?? this.names,
        surnames: surnames ?? this.surnames,
        curp: curp ?? this.curp,
        email: email ?? this.email,
        cellphone: cellphone ?? this.cellphone,
        idbio: idbio ?? this.idbio,
        registrationType: registrationType ?? this.registrationType,
        registrationNumber: registrationNumber ?? this.registrationNumber,
        studentSignaturePath: studentSignaturePath ?? this.studentSignaturePath,
        studentPhotoPath: studentPhotoPath ?? this.studentPhotoPath,
        studentQrPath: studentQrPath ?? this.studentQrPath,
        qr: qr ?? this.qr,
        career: career ?? this.career,
        grade: grade ?? this.grade,
        group: group ?? this.group,
        turn: turn ?? this.turn,
        fecha: fecha == null ? 'a' : 'b',
        hora: hora ?? 'a',
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'names': names,
        'surnames': surnames,
        'curp': curp,
        'email': email,
        'cellphone': cellphone,
        'idbio': idbio,
        'registration_type': registrationType,
        'registration_number': registrationNumber,
        'student_signature_path': studentSignaturePath,
        'student_photo_path': studentPhotoPath,
        'student_qr_path': studentQrPath,
        'qr': qr,
        'fecha': fecha ?? 's',
        'hora': hora ?? 'd',
        'career': career.toMap(),
        'grade': grade.toMap(),
        'group': group.toMap(),
        'turn': turn.toMap(),
      };
}
