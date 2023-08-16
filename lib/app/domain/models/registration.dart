import 'dart:convert';

import 'package:datamex_master_app/app/domain/models/careers.dart';
import 'package:datamex_master_app/app/domain/models/grades.dart';
import 'package:datamex_master_app/app/domain/models/groups.dart';
import 'package:datamex_master_app/app/domain/models/turns.dart';

class RegistrationModel {
  RegistrationModel(
      {required this.id,
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
      required this.date,
      required this.hour});

  factory RegistrationModel.fromJson(String str) =>
      RegistrationModel.fromMap(json.decode(str));

  factory RegistrationModel.fromMap(Map<String, dynamic> json) =>
      RegistrationModel(
        id: json['id'],
        names: json['names'],
        surnames: json['surnames'],
        curp: json['curp'],
        email: json['email'],
        cellphone: json['cellphone'],
        idbio: json['idbio'],
        registrationType: json['registration_type'],
        registrationNumber: json['registration_number'],
        studentSignaturePath: json['student_signature_path'],
        studentPhotoPath: json['student_photo_path'],
        studentQrPath: json['student_qr_path'],
        qr: json['qr'],
        career: CareerModel.fromMap(json['career']),
        grade: GradesModel.fromMap(json['grade']),
        group: GroupsModel.fromMap(json['group']),
        turn: TurnsModel.fromMap(json['turn']),
        date: json['date'],
        hour: json['hour'],
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
  String? studentSignaturePath;
  dynamic studentPhotoPath;
  dynamic studentQrPath;
  String qr;
  CareerModel career;
  GradesModel grade;
  GroupsModel group;
  TurnsModel turn;
  String? date;
  String? hour;

  RegistrationModel copyWith(
          {String? id,
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
          CareerModel? career,
          GradesModel? grade,
          GroupsModel? group,
          TurnsModel? turn,
          String? date,
          String? hour}) =>
      RegistrationModel(
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
        date: date ?? this.date,
        hour: hour ?? this.hour,
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
        'career': career.toMap(),
        'grade': grade.toMap(),
        'group': group.toMap(),
        'turn': turn.toMap(),
      };
}
