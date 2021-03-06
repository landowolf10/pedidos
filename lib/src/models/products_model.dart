import 'dart:convert';

import 'package:pedidos/src/pages/carrito.dart';
import 'package:pedidos/src/pages/login.dart';
import 'package:http/http.dart' as http;

class Products {
  String nombreProducto;
  double precioProducto;
  String imagenProducto;
  String descripcionProducto;

  Products(
      {this.nombreProducto,
      this.precioProducto,
      this.imagenProducto,
      this.descripcionProducto});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
        nombreProducto: json['nombre'],
        precioProducto: json['precio'],
        imagenProducto: json['imagen'],
        descripcionProducto: json['descripcion']);
  }

  Map<String, dynamic> toJson() {
    return {
      "pedido": pedidoFinal,
      "total": total,
      "id_c": idUsuario,
      "nombre": nombreCliente,
      "telefono": telefonoCliente,
      "colonia": coloniaCliente,
      "calle": calleCliente,
      "numero": numeroCalle,
      "estatus_p": 1
    };
  }

  void realizarPedido() async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/realizarPedido.php";

    final response = await http.post(url, body: {
      "pedido": pedidoFinal,
      "total": total.toString(),
      "id_c": idUsuario.toString(),
      "nombre": nombreCliente,
      "telefono": telefonoCliente,
      "colonia": coloniaCliente,
      "calle": calleCliente,
      "numero": numeroCalle,
      "estatus_p": 1.toString()
    });

    print("Respuesta: " + response.body);
  }

  void sendPush() async {
    var url = "http://10.0.2.2:5000/push";

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          "cliente": nombreCliente,
          "pedido": pedidoFinal,
          "cantidad": cantidadProducto
              .toString()
              .replaceAll("[", "")
              .replaceAll("]", ""),
          "telefono": telefonoCliente,
          "colonia": coloniaCliente,
          "calle": calleCliente,
          "numero": numeroCalle
        }));

    print("Respuesta push: " + response.body);
  }
}
