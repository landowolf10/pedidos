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
}