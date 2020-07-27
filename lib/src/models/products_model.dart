class Products {
  String nombreProducto;
  String precioProducto;
  String imagenProducto;

  Products(
      {this.nombreProducto,
      this.precioProducto,
      this.imagenProducto});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
        nombreProducto: json['nombre'],
        precioProducto: json['precio'],
        imagenProducto: json['imagen']);
  }
}