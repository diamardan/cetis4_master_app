class RegistrationFormData {
  RegistrationFormData(
      {required this.names,
      required this.surnames,
      required this.curp,
      required this.registration_number,
      required this.email,
      required this.cellphone,
      required this.grade,
      required this.group,
      required this.turn,
      required this.career,
      required this.student_signature_path});
  Map<String, dynamic> toJson() {
    return {
      'names': names,
      'surnames': surnames,
      'curp': curp,
      'registration_number': registration_number,
      'grade': grade,
      'group': group,
      'turn': turn,
      'career': career,
      'email': email,
      'cellphone': cellphone,
      'student_signature_path': student_signature_path
    };
  }

  String names;
  String surnames;
  String curp;
  String registration_number;
  String grade;
  String group;
  String turn;
  String career;
  String email;
  String cellphone;
  String? student_signature_path;
}
