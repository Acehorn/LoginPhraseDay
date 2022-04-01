import 'package:flutter/material.dart';

dialogOpen(
  context,
  String body,
) {
  String message = "Error en la solicitud";
  if (body == "EMAIL_NOT_FOUND") {
    message = "El correo no ha sido registrado aún.";
  } else if (body == "INVALID_PASSWORD") {
    message = "Contraseña incorrecta, favor de verificar";
  } else if (body == "EMAIL_EXISTS") {
    message = "Este correo ya fue registrado";
  } else if (body == "proximamente") {
    message = "Opción aun no disponible";
  }
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text("Alerta"),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text(
            'Aceptar',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    ),
  );
}

showLoader(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => Center(
          child: Container(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  valueColor: AlwaysStoppedAnimation(Colors.white)))));
}

hideLoader(context) {
  Navigator.pop(context);
}
