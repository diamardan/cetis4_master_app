import 'dart:io';

import 'package:datamex_master_app/app/data/services/remote/careers.service.dart';
import 'package:datamex_master_app/app/data/services/remote/grades.service.dart';
import 'package:datamex_master_app/app/data/services/remote/groups.service.dart';
import 'package:datamex_master_app/app/data/services/remote/registrations.service.dart';
import 'package:datamex_master_app/app/data/services/remote/turns.service.dart';
import 'package:datamex_master_app/app/domain/models/careers.dart';
import 'package:datamex_master_app/app/domain/models/grades.dart';
import 'package:datamex_master_app/app/domain/models/groups.dart';
import 'package:datamex_master_app/app/domain/models/registration.form.dart';
import 'package:datamex_master_app/app/domain/models/turns.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_autocomplete_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_dropdown_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_form_button_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_photo_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_signature_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_textformfield_widget.dart';
import 'package:datamex_master_app/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class AddRegistrationView extends StatefulWidget {
  const AddRegistrationView({Key? key}) : super(key: key);

  @override
  State<AddRegistrationView> createState() => _AddRegistrationViewState();
}

class _AddRegistrationViewState extends State<AddRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  double separacion = 1;
  final TextEditingController _namesController = TextEditingController();
  final TextEditingController _surnamesController = TextEditingController();
  final TextEditingController _curpController = TextEditingController();
  final TextEditingController _registrationNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cellphoneController = TextEditingController();
  final RegistrationsService _registrationsService = RegistrationsService();
  final CareersService _careersService = CareersService();
  List<CareerModel> _careers = [];
  String _selectedCareer = '';
  final GradesService _gradesService = GradesService();
  List<GradesModel> _grades = [];
  String _selectedGrade = '';
  final GroupsService _groupsService = GroupsService();
  List<GroupsModel> _groups = [];
  String _selectedGroup = '';
  final TurnsService _turnsService = TurnsService();
  List<TurnsModel> _turns = [];
  String _selectedTurn = '';
  String _loadingStatusMessage = 'Enviando Datos';
  bool _formLoading = false;
  File?
      _selectedPhotoImageFile; // Variable para almacenar el archivo seleccionado
  File?
      _selectedVoucherImageFile; // Variable para almacenar el archivo seleccionado
  bool searching = true;
  bool hasSign = false;
  String _signatureId = '';
  final SignatureController _signatureController =
      SignatureController(exportBackgroundColor: Colors.white);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchDropdowns();
  }

  void setLoading(bool load) {
    setState(() {
      _formLoading = load;
    });
  }

  void populateForm(Map<String, dynamic> predata) async {
    print(predata);
    _namesController.text = predata['names'];
    _surnamesController.text = predata['surnames'];
    _curpController.text = predata['curp'];
    _emailController.text = predata['email'];
    _cellphoneController.text = predata['cellphone'];
    _registrationNumberController.text = predata['registration_number'];
    if (predata['student_signature_path'] is String &&
        predata['student_signature_path'].isNotEmpty) {
      print('ya estoy aqui jajajajajaja 😎😎😎😎😎😎');
      hasSign = true;
      _signatureId = predata['student_signature_path'];
    }
    setState(() {
      print(hasSign);
      _selectedCareer = predata['career'];
      _selectedGrade = predata['grade'];
      _selectedGroup = predata['group'];
      _selectedTurn = predata['turn'];
    });
  }

  Future<void> _fetchDropdowns() async {
    _careers = await _careersService.getCareers();
    _grades = await _gradesService.getGrades();
    _groups = await _groupsService.getGroups();
    _turns = await _turnsService.getTurns();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DatamexAppBarWidget(title: 'Agregar registro'),
      body: Stack(children: [
        Card(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: searching
                          ? DatamexAutocompleteWidget(
                              onSuggestionSelected: (suggestion) async {
                                populateForm(suggestion);

                                setState(() {
                                  searching = false;
                                });
                              },
                            )
                          : Column(
                              children: [
                                registrationPersonalData(),
                                registrationSchoolData(),
                                photoCaptureSection(),
                                voucherCaptureSection(),
                                signatureCaptureOrView(),
                                formButtons(),
                              ],
                            ),
                    )),
              ),
            ),
          ),
        ),
        if (_formLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                      color: Colors.blue.shade500,
                      backgroundColor: Colors.blue.shade700),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    _loadingStatusMessage,
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
      ]),
    );
  }

  Widget signatureCaptureOrView() {
    if (hasSign) {
      return Image.network('https://drive.google.com/uc?id=$_signatureId');
    } else {
      return DatamexSignaturePad(controller: _signatureController);
    }
  }

  Widget registrationPersonalData() {
    return Column(
      children: [
        const Center(
          child: Text(
            'Información del alumno',
            style: TextStyle(fontSize: 20),
          ),
        ),
        DatamexTextFormField(
            labelText: 'Nombres',
            boxHeight: separacion,
            validate: true,
            controller: _namesController),
        DatamexTextFormField(
          labelText: 'Apellidos',
          boxHeight: separacion,
          validate: true,
          controller: _surnamesController,
        ),
        DatamexTextFormField(
            labelText: 'Curp',
            boxHeight: separacion,
            maxLength: 18,
            minLength: 18,
            validate: true,
            controller: _curpController),
        DatamexTextFormField(
            labelText: 'Matrícula',
            boxHeight: separacion,
            validate: false,
            controller: _registrationNumberController),
        DatamexTextFormField(
          labelText: 'Correo',
          boxHeight: separacion,
          validate: true,
          isEmail: true,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        DatamexTextFormField(
          labelText: 'Celular',
          boxHeight: separacion,
          validate: true,
          minLength: 10,
          maxLength: 10,
          controller: _cellphoneController,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget registrationSchoolData() {
    return Column(children: [
      const Center(
        child: Text(
          'Información del plantel',
          style: TextStyle(fontSize: 20),
        ),
      ),
      DatamexDropDownMenuWidget<CareerModel>(
        items: _careers,
        labelText: 'Carrera',
        initialValue: _selectedCareer,
        onChanged: (selectedValue) {
          _selectedCareer = selectedValue.id;
          print('selected career: ${selectedValue.name}');
        },
      ),
      DatamexDropDownMenuWidget<GradesModel>(
        items: _grades,
        labelText: 'Grado',
        initialValue: _selectedGrade,
        onChanged: (selectedValue) {
          _selectedGrade = selectedValue.id;
          print('selected grade: ${selectedValue.name}');
        },
      ),
      DatamexDropDownMenuWidget<GroupsModel>(
        items: _groups,
        labelText: 'Grupo',
        initialValue: _selectedGroup,
        onChanged: (selectedValue) {
          _selectedGroup = selectedValue.id;
          print('selected group: ${selectedValue.name}');
        },
      ),
      DatamexDropDownMenuWidget<TurnsModel>(
        items: _turns,
        labelText: 'Turno',
        initialValue: _selectedTurn,
        onChanged: (selectedValue) {
          _selectedTurn = selectedValue.id;
          print('selected turn: ${selectedValue.name}');
        },
      ),
    ]);
  }

  Widget signaturePad() {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade800),
                onPressed: () {
                  _signatureController.clear();
                },
                child: const Icon(Icons.delete)),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Signature(
              controller: _signatureController,
              height: 120,
              width: MediaQuery.of(context).size.width * .90,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget formButtons() {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DatamexFormButton(
              color: Colors.green.shade800,
              onPress: () {
                setLoading(true);
                setState(() {
                  _loadingStatusMessage = 'Espere un momento';
                });
                handleForm(context, _formKey);
              },
              label: 'Guardar',
            ),
            DatamexFormButton(
              color: Colors.red.shade800,
              onPress: () {
                Navigator.of(context).pop();
              },
              label: 'Cancelar',
            ),
          ],
        ),
      ],
    );
  }

  void changeStatusMessage(String message) {
    setState(() {
      _loadingStatusMessage = message;
    });
  }

  void resetLoaderStatus() {
    setState(() {
      _formLoading = false;
      _loadingStatusMessage = 'Enviando datos!';
    });
  }

  void handleForm(
      BuildContext currentContext, GlobalKey<FormState> formKey) async {
    if (_signatureController.isEmpty && hasSign == false) {
      resetLoaderStatus();
      return notifyDialog(
          currentContext, 'Debe ingresar una firma para continuar');
    }
    if (_selectedPhotoImageFile == null) {
      resetLoaderStatus();
      return notifyDialog(currentContext,
          'Debe tomar una fotografía del alumno para continuar');
    }
    if (_selectedVoucherImageFile == null) {
      resetLoaderStatus();
      return notifyDialog(currentContext,
          'Debe tomar una fotografía del voucher para continuar');
    }
    changeStatusMessage('obteniendo firma');
    var firma = await _signatureController.toPngBytes();
    changeStatusMessage('validando formulario');

    if (formKey.currentState!.validate()) {
      final names = _namesController.text;
      final surnames = _surnamesController.text;
      final curp = _curpController.text;
      final registrationNumber = _registrationNumberController.text;
      final email = _emailController.text;
      final cellphone = _cellphoneController.text;

      RegistrationFormData formData = RegistrationFormData(
          names: names,
          surnames: surnames,
          curp: curp,
          registration_number: registrationNumber,
          email: email,
          cellphone: cellphone,
          grade: _selectedGrade,
          group: _selectedGroup,
          turn: _selectedTurn,
          career: _selectedCareer,
          student_signature_path: _signatureId);

      Map<String, dynamic> response =
          await _registrationsService.addRegistration(
        formData,
        _selectedPhotoImageFile,
        _selectedVoucherImageFile,
        firma,
      );

      setLoading(false);
      print('$response solo response');
      print('${response["error"]} errir');
      print('${response["responseJson"]} json');
      print('${response.containsKey("message")} contiene');
      print('${response["code"]}---code');
      print('${response["statusCode"]} estats');
      if (response.containsKey('error')) {
        notifyDialog(context, response['error']);
      } else if (response.containsKey('responseJson')) {
        final responseJson = response['responseJson'];
        if (responseJson.containsKey('code') &&
            responseJson['code'] >= 200 &&
            responseJson['code'] < 300) {
          if (responseJson.containsKey('message') &&
              responseJson['message'] == 'success') {
            print('nos estamos moviendo');
            Navigator.pushReplacementNamed(context, Routes.registrations);
          } else if (responseJson.containsKey('message') &&
              responseJson['message'].contains('Key (curp)')) {
            final errorMessage = responseJson['message'].split('=')[1];
            notifyDialog(context, errorMessage);
          } else {
            notifyDialog(context, 'Error desconocido');
          }
        } else {
          if (responseJson.containsKey('error')) {
            notifyDialog(context, responseJson['error']);
          } else {
            print('Manejar otro caso si es necesario');
          }
        }
      } else {
        notifyDialog(context, 'Error desconocido');
      }
      // Cerrar el modal después de guardar
      //Navigator.pushReplacementNamed(currentContext, Routes.personal);
    }
    resetLoaderStatus();
  }

  void notifyDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void handlePhotoSelected(File? imageFile) async {
    setLoading(true);
    changeStatusMessage('Comprimiendo Foto');

    setState(() {
      _selectedPhotoImageFile = imageFile;
    });
    resetLoaderStatus();
  }

  void handleVoucherSelected(File? imageFile) {
    setState(() {
      _selectedVoucherImageFile = imageFile;
    });
  }

  Widget photoCaptureSection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Foto del alumno',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        DatamexCameraWidget(
            onImageSelected: handlePhotoSelected,
            loadStatusCallback: setLoading,
            changeStatusMessageCallback: changeStatusMessage),
      ],
    );
  }

  Widget voucherCaptureSection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Captura de voucher',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        DatamexCameraWidget(
          onImageSelected: handleVoucherSelected,
          loadStatusCallback: setLoading,
          changeStatusMessageCallback: changeStatusMessage,
        ),
      ],
    );
  }
}
