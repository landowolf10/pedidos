import 'package:pedidos/src/pages/carrito.dart';
import 'package:pedidos/src/pages/login.dart';
import 'package:http/http.dart' as http;

class Users {
  int idUsuario;
  String nombreUsuario;
  String emailUsuario;
  String apellidoPaterno;
  String apellidoMaterno;
  String telefono;
  String estado;
  String ciudad;
  String colonia;
  String calle;
  String numero;
  String pass;
  String tipoUsuario;
  String firebaseToken;

  Users({
    this.idUsuario,
    this.emailUsuario,
    this.nombreUsuario,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.telefono,
    this.estado,
    this.ciudad,
    this.colonia,
    this.calle,
    this.numero,
    this.pass,
    this.tipoUsuario,
    this.firebaseToken,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        idUsuario: json['id'],
        emailUsuario: json['email'],
        nombreUsuario: json['nombre'],
        apellidoPaterno: json['apellido_paterno'],
        apellidoMaterno: json['apellido_materno'],
        telefono: json['telefono'],
        estado: json['estado'],
        ciudad: json['ciudad'],
        colonia: json['colonia'],
        calle: json['calle'],
        numero: json['numero'],
        pass: json['pass'],
        tipoUsuario: json['tipo_usuario'],
        firebaseToken: json['firebase_token']);
  }
}
