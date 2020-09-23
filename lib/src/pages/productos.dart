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
  //List data;

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

  /*Future<List<Products>> obtenerPlatillos() async {
    var response = await http.get("http://10.0.2.2:5000/platillos");

    if (response.statusCode == 200) {
      //print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Products> responses =
            data.map((j) => Products.fromJson(j)).toList();

        dishesList = responses;

        /*List<dynamic> items = json
            .decode(utf8.decode(response.bodyBytes))
            .cast<Map<String, dynamic>>();

        dishesList = items.map<Products>((json) {
          return Products.fromJson(json);
        }).toList();*/

        //print(listOfProducts);
      }

      //print(listOfProducts);
    }

    return dishesList;
  }*/

  /*Future<Products> obtenerPlatillos() async {
    final response = await http.get('http://10.0.2.2:5000/platillos');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Products.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }*/

  /*Future<List<Products>> obtenerPlatillos() async {
    final uri = 'http://10.0.2.2:5000/platillos';
    final response =
        await http.get(uri, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      print(jsonResponse);

      return jsonResponse.map((item) => new Products.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }*/

  /*Future<List<Products>> obtenerPlatillos() async {
    final uri = 'http://10.0.2.2:5000/platillos';
    var response = await http.get(uri);

    //print(response.body);

    print("STATUS CODE: " + response.statusCode.toString());

    if (response.statusCode == 200) {
      final items = json.decode(response.body) as List<dynamic>;

      print(items);
      print("SI ENTRA");

      //print("ITEMS: " + items);

      /*dishesList = items.map<Products>((json) {
        return Products.fromJson(json);
      }).toList();

      print("dishesList: " + dishesList.toString());*/

      /*dishesList = jsonDecode(response.body)
          .map((item) => Products.fromJson(item))
          .toList()
          .cast<Products>();*/

      dishesList = items.map((i) => Products.fromJson(i)).toList();

      print("dishesList: " + dishesList.toString());

      return dishesList;
    } else {
      throw Exception('Failed to load internet');
    }
  }*/

  Future<List<Products>> obtenerPlatillos() async {
    final response = await http.get('http://10.0.2.2:5000/platillos');

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      dishesList = parsed.map<Products>((json) {
        return Products.fromJson(json);
      }).toList();
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }

    return dishesList;
  }

  Future<List<Products>> obtenerBebidas() async {
    final response = await http.get('http://10.0.2.2:5000/bebidas');

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      drinksList = parsed.map<Products>((json) {
        return Products.fromJson(json);
      }).toList();
    } else {
      throw Exception('Unable to fetch products from the REST API');
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
