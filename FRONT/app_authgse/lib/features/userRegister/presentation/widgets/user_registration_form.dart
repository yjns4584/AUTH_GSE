import 'package:flutter/material.dart';

class UserRegistrationForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController userNameController;
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController documentTypeController;
  final TextEditingController documentNumberController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController telephoneController;

  const UserRegistrationForm({
    super.key,
    required this.formKey,
    required this.userNameController,
    required this.nameController,
    required this.lastNameController,
    required this.documentTypeController,
    required this.documentNumberController,
    required this.emailController,
    required this.passwordController,
    required this.telephoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: userNameController,
              decoration: InputDecoration(
                labelText: 'Nombre Usuario',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa un nombre de usuario';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: nameController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Nombres',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Error de servidor, datos de cédula no recibidos';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: lastNameController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Apellidos',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Error de servidor, datos de cédula no recibidos';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: documentTypeController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Tipo de documento',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                suffixIcon: PopupMenuButton<String>(
                  icon: Icon(Icons.arrow_drop_down),
                  onSelected: (String documentType) {
                    documentTypeController.text = documentType.toUpperCase();
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      'Cédula de ciudadanía',
                      'Cédula de extranjería',
                      'Pasaporte'
                    ].map<PopupMenuItem<String>>((String documentType) {
                      return PopupMenuItem<String>(
                        value: documentType,
                        child: Text(documentType),
                      );
                    }).toList();
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Error de servidor, datos de cédula no recibidos';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: documentNumberController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Número documento',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Error de servidor, datos de cédula no recibidos';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return 'Ingresa un correo valido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa una contraseña valida';
                } else if (value.length < 6) {
                  return 'Contraseña debe ser mayor de 6 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: telephoneController,
              decoration: InputDecoration(
                labelText: 'Teléfono',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa un número de teléfono';
                } else if (!RegExp(r"^\d{10}$").hasMatch(value)) {
                  return 'Ingresa un número de teléfono válido de 10 dígitos';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
