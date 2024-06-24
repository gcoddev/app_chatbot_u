import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff0686ff);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF0686AA), Color(0xFF0686FF)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.black;

const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp textWithSpacesValidatorRegExp = RegExp(r'^[a-zA-Z0-9 ]*$');
final RegExp textWithoutSpacesValidatorRegExp = RegExp(r'^[a-zA-Z0-9]*$');
final RegExp emailValidatorRegExp =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
const String kEmailNullError = "El correo es obligatorio";
const String kInvalidEmailError = "El correo es invalido";
const String kUsernameNullError = "El usuario es obligatorio";
const String kInvalidUsernameError = "El usuario es invalido";
const String kPassNullError = "Debe ingresar su contraseña";
const String kShortPassError = "La contraseña es muy corta";
const String kMatchPassError = "Las contraseñas no coinciden";
const String kNamelNullError = "Por favor ingrese su nombre";
const String kPhoneNumberNullError = "Por favor ingrese su numero";
const String kAddressNullError = "Por favor ingrese su direccion";

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: kTextColor),
  );
}

// CHATBOT
const kDefaultPadding = 20.0;
const kErrorColor = Color(0xFFF03738);
