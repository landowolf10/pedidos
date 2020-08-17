import 'package:pedidos/src/pages/login.dart';
import 'package:pedidos/src/pages/productos3.dart';

class Products {
  String nombreProducto;
  String precioProducto;
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
      "pedido_realizado": pedidoRealizado,
      "total_pagar": total,
      "id_cliente": idUsuario,
      /*"nombre_cliente": listaTipoPago,
      "colonia": listaTipoCliente,
      "calle": listaTPV,
      "numero": listaTPV,
      "estatus": listaTPV*/
    };
  }
}