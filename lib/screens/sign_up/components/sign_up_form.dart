import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import '../../../components/form_error.dart';
import '../../../constants.dart';
// import '../../complete_profile/complete_profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:chatbot_u/screens/sign_in/sign_in_screen.dart';
import 'package:chatbot_u/env.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? ciNumber;
  String? expedido;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? nombres;
  DateTime? fechaNacimiento;
  String? celular;
  String? email;
  String? username;
  String? password;
  String? conformPassword;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Construir el cuerpo de la solicitud
      final Map<String, dynamic> userData = {
        'ci': ciNumber,
        'expedido': expedido,
        'paterno': apellidoPaterno,
        'materno': apellidoMaterno,
        'nombres': nombres,
        'nacimiento': fechaNacimiento?.toIso8601String(),
        'celular': celular,
        'email': email,
        'username': username,
        'password': password,
      };

      // Realizar la solicitud POST
      final response = await http.post(
        Uri.parse(apiUrl + '/api/usuariosApp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      // Manejar la respuesta
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Si la solicitud fue exitosa, navegar a la siguiente pantalla
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Registro exitoso, ahora proceda a iniciar sesion')),
        );
        Navigator.pushNamed(context, SignInScreen.routeName);
      } else {
        // Si hubo un error, mostrar un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrarse: ${response.body}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            onSaved: (newValue) => ciNumber = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su número de CI';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "CI",
              hintText: "Ingrese su número de CI",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: expedido,
            onChanged: (newValue) {
              setState(() {
                expedido = newValue;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Seleccione el lugar de expedición';
              }
              return null;
            },
            items: <String>[
              'LP',
              'OR',
              'PT',
              'PD',
              'BN',
              'SCZ',
              'CO',
              'CH',
              'TJ',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: const InputDecoration(
              labelText: "Expedido",
              hintText: "Seleccione el lugar de expedición",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            onSaved: (newValue) => apellidoPaterno = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su apellido paterno';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Apellido Paterno",
              hintText: "Ingrese su apellido paterno",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            onSaved: (newValue) => apellidoMaterno = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su apellido materno';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Apellido Materno",
              hintText: "Ingrese su apellido materno",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            onSaved: (newValue) => nombres = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese sus nombres';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Nombres",
              hintText: "Ingrese sus nombres",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Fecha de Nacimiento",
              hintText: fechaNacimiento != null
                  ? DateFormat('dd/MM/yyyy').format(fechaNacimiento!)
                  : "Seleccione su fecha de nacimiento",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null && pickedDate != fechaNacimiento) {
                setState(() {
                  fechaNacimiento = pickedDate;
                });
              }
            },
            validator: (value) {
              if (fechaNacimiento == null) {
                return 'Seleccione su fecha de nacimiento';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.phone,
            onSaved: (newValue) => celular = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su número de celular';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Celular",
              hintText: "Ingrese su número de celular",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return 'Por favor ingrese su correo electrónico';
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return 'Por favor ingrese un correo electrónico válido';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Ingrese su correo electrónico",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => username = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kUsernameNullError);
              } else if (textWithoutSpacesValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidUsernameError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kUsernameNullError);
                return 'Por favor ingrese su nombre de usuario';
              } else if (!textWithoutSpacesValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidUsernameError);
                return 'Por favor ingrese un usuario valido';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Nombre de usuario",
              hintText: "Ingrese su nombre de usuario",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return 'Por favor ingrese su contraseña';
              } else if (value.length < 8) {
                addError(error: kShortPassError);
                return 'La contraseña debe tener al menos 8 caracteres';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Contraseña",
              hintText: "Ingrese su contraseña",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => conformPassword = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.isNotEmpty && password == conformPassword) {
                removeError(error: kMatchPassError);
              }
              conformPassword = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return 'Por favor confirme su contraseña';
              } else if ((password != value)) {
                addError(error: kMatchPassError);
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Confirmar Contraseña",
              hintText: "Re-ingrese su contraseña",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          // FormError(errors: errors),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text("Continuar"),
          ),
        ],
      ),
    );
  }
}
