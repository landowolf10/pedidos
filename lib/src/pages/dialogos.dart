import 'package:flutter/material.dart';

class Dialogos {
  void insertedClientDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Proceso realizado con éxito"),
          content: new Text("El cliente se registró exitosamente."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Aceptar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void noPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("No cuenta con permisos"),
          content: new Text("El usuario no tiene permiso para iniciar sesión."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Aceptar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void invalidDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Datos inválidos"),
          content: new Text("Usuario y/o contraseña incorrectos."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Aceptar"),
              onPressed: () {
                //state = 0;

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void emptyBoxesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Campos vacíos"),
          content: new Text("Favor de llenar los campos para iniciar sesión."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Aceptar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void errorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Error"),
          content:
              new Text("Ocurrió un error con el servidor, intente de nuevo."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Aceptar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void connectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Error de red"),
          content: new Text("No existe una conexión a internet."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Aceptar"),
              onPressed: () {
                //state = 0;

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void invalidPhoneDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Número inválido"),
          content:
              new Text("Favor de ingresar un número válido de 10 dígitos."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Aceptar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void emptyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Campos vacíos"),
          content: new Text("Favor de llenar todos los campos."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Aceptar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
