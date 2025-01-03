import 'package:app_authgse/common/widgets/custom_outline_button.dart';
import 'package:app_authgse/common/widgets/custom_page_template.dart';
import 'package:app_authgse/features/userLogin/presentation/widgets/user_login_form.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inicio de sesión exitoso.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageTemplate(
      title: const Center(
        child: Text(
          'Inicio de Sesión',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserLoginForm(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController)
        ],
      ),
      button: SizedBox(
        width: double.infinity,
        height: 80,
        child: CustomOutlinedButton(
            onPressed: _submitLogin, label: 'Iniciar Sesión'),
      ),
    );
  }
}
