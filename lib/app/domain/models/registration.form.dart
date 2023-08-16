class RegistrationFormData {
  RegistrationFormData({
    required this.names,
    required this.surnames,
    required this.curp,
    required this.registration_number,
    required this.email,
    required this.cellphone,
    required this.grade,
    required this.group,
    required this.turn,
    required this.career,
  });
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
}
