import 'package:app_authgse/common/widgets/custom_outline_button.dart';
import 'package:app_authgse/common/widgets/custom_page_template.dart';
import 'package:app_authgse/features/faceCapture/presentation/pages/face_capture.pages.dart';
import 'package:app_authgse/features/userRegister/presentation/widgets/user_registration_form.dart';
import 'package:flutter/material.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _documentTypeController = TextEditingController();
  final _documentNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telephoneController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _documentNumberController.dispose();
    _documentTypeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      logger.debug('Username: ${_userNameController.text}');
      logger.debug('Name: ${_nameController.text}');
      logger.debug('Last Name: ${_lastNameController.text}');
      logger.debug('Document Type: ${_documentTypeController.text}');
      logger.debug('Document Number: ${_documentNumberController.text}');
      logger.debug('Email: ${_emailController.text}');
      logger.debug('Password: ${_passwordController.text}');
      logger.debug('Telephone: ${_telephoneController.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro completo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomPageTemplate(
          title: const Text(
            'Registro usuario',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserRegistrationForm(
                formKey: _formKey,
                userNameController: _userNameController,
                nameController: _nameController,
                lastNameController: _lastNameController,
                documentTypeController: _documentTypeController,
                documentNumberController: _documentNumberController,
                emailController: _emailController,
                passwordController: _passwordController,
                telephoneController: _telephoneController,
              )
            ],
          ),
          button: SizedBox(
              height: 80.0,
              width: double.infinity,
              child: CustomOutlinedButton(
                  onPressed: _submitForm, label: 'Registrarme')),
        ));
  }
}
