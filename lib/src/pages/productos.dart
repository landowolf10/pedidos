import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:pedidos/src/models/products_model.dart';
import 'package:pedidos/src/pages/bebidas.dart';
import 'package:pedidos/src/pages/carrito.dart';
import 'package:pedidos/src/pages/platillos.dart';

List<String> precioProducto = new List<String>();

class Productos extends StatefulWidget {
  @override
  ProductosState createState() => new ProductosState();
}

class ProductosState extends State<Productos>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Products> drinksList;
  List<Products> dishesList;

  /*@override
  void initState() {
    initialization();
    super.initState();
  }

  initialization() async {

    listaBebidas.clear();

    await obtenerPlatillos();
    //await obtenerBebidas();
  }*/

  /*obtenerPlatillos() async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getPlatillos.php";

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> listaProductos = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      //listaPlatillos.clear();

      for (int i = 0; i < listaProductos.length; i++) {
        listaPlatillos.add(listaProductos[i]["nombre"]);
        listaPreciosPlatillos.add(listaProductos[i]["precio"]);
        descripcionPlatillo.add(listaProductos[i]["descripcion"]);
        imagenPlatillo.add(listaProductos[i]["imagen"]);
        precioPlatillo.add(listaProductos[i]["precio"]);
        cantidadPlatillo.add(1);
      }
    }
  }*/

  Future<List<Products>> obtenerPlatillos() async {
    var response = await http.get(
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getPlatillos.php");

    if (response.statusCode == 200) {
      List<dynamic> items = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      dishesList = items.map<Products>((json) {
        return Products.fromJson(json);
      }).toList();

      //print(listOfProducts);
    }

    return dishesList;
  }

  Future<List<Products>> obtenerBebidas() async {
    var response = await http
        .get("https://pruebasbotanax.000webhostapp.com/Pedidos/getBebidas.php");

    if (response.statusCode == 200) {
      List<dynamic> items = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      drinksList = items.map<Products>((json) {
        return Products.fromJson(json);
      }).toList();

      //print(listOfProducts);
    }

    return drinksList;
  }

  /*obtenerBebidas() async {
    var url = "https://pruebasbotanax.000webhostapp.com/Pedidos/getBebidas.php";

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> listaProductos = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      print("Bebidas: " + listaProductos.toString());

      //listaBebidas.clear();

      for (int i = 0; i < listaProductos.length; i++) {
        listaBebidas.add(listaProductos[i]["nombre"]);
        listaPreciosBebidas.add(listaProductos[i]["precio"]);
        descripcionBebida.add(listaProductos[i]["descripcion"]);
        imagenBebida.add(listaProductos[i]["imagen"]);
        precioBebida.add(listaProductos[i]["precio"]);
        cantidadBebida.add(1);
      }

      print(listaProductos);
    }
  }*/

  /*void showDefaultSnackbar(BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Producto agregado al carrito'),
    ));
    /*Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Producto agregado al carrito"),
        action: SnackBarAction(
          label: "Ir al carrito",
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext ctx) => Carrito()));
          },
        ),
      ),
    );*/
  }*/

  @override
  Widget build(BuildContext context) {
    /*final logo = Hero(
      tag: "hero",
      child: Image.asset("img/botanaxLogo.png"),
    );*/

    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 150),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 150.0,
                      height: 150.0,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.red,
                          child: Column(
                            children: [
                              Image.asset(
                                "icons/entradas.png",
                                width: 80,
                                height: 80,
                              ),
                              Text(
                                'Entradas',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: () {}),
                    ),
                    SizedBox(width: 50),
                    ButtonTheme(
                      minWidth: 150.0,
                      height: 150.0,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.red,
                          child: Column(
                            children: [
                              Image.asset(
                                "icons/platillos.png",
                                width: 80,
                                height: 80,
                              ),
                              Text(
                                'Platillos',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext ctx) =>
                                        Platillos()));
                          }),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 150.0,
                      height: 150.0,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.red,
                          child: Column(
                            children: [
                              Image.asset(
                                "icons/bebidas.png",
                                width: 80,
                                height: 80,
                              ),
                              Text(
                                'Bebidas',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext ctx) => Bebidas()));
                          }),
                    ),
                    SizedBox(width: 50),
                    ButtonTheme(
                      minWidth: 150.0,
                      height: 150.0,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.red,
                          child: Column(
                            children: [
                              Image.asset(
                                "icons/postres.png",
                                width: 80,
                                height: 80,
                              ),
                              Text(
                                'Postres',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: () {}),
                    ),
                  ],
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 44.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.red,
                      child: Text(
                        'Ir al carrito',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext ctx) => Carrito()));
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
