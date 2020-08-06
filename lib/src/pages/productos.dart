import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:pedidos/src/models/products_model.dart';
import 'package:pedidos/src/pages/carrito.dart';
import 'package:pedidos/src/pages/platillos.dart';

String pedido = "";
double total = 0;

List<String> pedidoRealizado = new List<String>();
List<String> precioProducto = new List<String>();

/*List<String> selectedProduct = new List<String>();
List<String> productDescription = new List<String>();
List<String> productImage = new List<String>();
List<String> productPrice = new List<String>();*/

List<String> listaEntradas = new List<String>();
List<String> listaPlatillos = new List<String>();
List<String> listaBebidas = new List<String>();
List<String> listaPostres = new List<String>();

class Productos extends StatefulWidget {
  @override
  ProductosState createState() => new ProductosState();
}

class ProductosState extends State<Productos>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController tabController;
  int tabIndex = 0, elements = 0;

  List<Products> listOfProducts;

  @override
  void initState() {
    initialization();
    super.initState();
  }

  initialization() async {
    await obtenerPlatillos();
    //await obtenerBebidas();
  }

  mostrarEntradas(int index) async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getProducts.php";

    final response =
        await http.post(url, body: {"indice_categoria": index.toString()});

    if (response.statusCode == 200) {
      List<dynamic> listaProductos = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      listaEntradas.clear();

      for (int i = 0; i < listaProductos.length; i++)
        listaEntradas.add(listaProductos[i]["nombre"]);

      print(listaEntradas);
    }
  }

  /*obtenerPlatillos() async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getPlatillos.php";

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> listaProductos = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      listaEntradas.clear();

      for (int i = 0; i < listaProductos.length; i++)
        listaPlatillos.add(listaProductos[i]["nombre"]);

      print(listaEntradas);
    }
  }*/

  Future<List<Products>> obtenerPlatillos() async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getPlatillos.php";

    final response = await http.get(url);

    //print(response.body);

    List jsonResponse;

    if (response.statusCode == 200) {
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
      } else {
        throw Exception('Failed to load products from API');
      }
    }

    return jsonResponse
        .map((platillo) => new Products.fromJson(platillo))
        .toList();
  }

  /*Future<List<Products>> obtenerBebidas() async {
    var url = "https://pruebasbotanax.000webhostapp.com/Pedidos/getBebidas.php";

    final response = await http.get(url);

    print(response.body);

    List jsonResponse;

    if (response.statusCode == 200) {
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
      } else {
        throw Exception('Failed to load products from API');
      }
    }

    for (int i = 0; i < jsonResponse.length; i++) {
      selectedProduct.add(jsonResponse[i]["nombre"]);
      productDescription.add(jsonResponse[i]["descripcion"]);
      productPrice.add(jsonResponse[i]["precio"]);
      productImage.add(jsonResponse[i]["imagen"]);
    }

    return jsonResponse.map((bebida) => new Products.fromJson(bebida)).toList();
  }*/

  /*mostrarPostres(int index) async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getProducts.php";

    final response =
        await http.post(url, body: {"indice_categoria": index.toString()});

    if (response.statusCode == 200) {
      List<dynamic> listaProductos = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      listaPostres.clear();

      for (int i = 0; i < listaProductos.length; i++)
        listaPostres.add(listaProductos[i]["nombre"]);

      print(listaPostres);
    }
  }*/

  /*Widget buildListaPlatillos(data) {
    print("Data length: " + data.length.toString());

    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index].nombreProducto,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )),
            subtitle: Text(data[index].precioProducto,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )),
            trailing: Image.network(data[index].imagenProducto),
            onTap: () {
              print("Index: " + index.toString());
              //print("Productos seleccionados" + selectedProduct.toString());

              //productInfo(context, index);

              //pedidoRealizado.add(data[index].nombreProducto);
              //showDefaultSnackbar(context);
            },
          );
        });
  }*/

  /*Widget buildListaBebidas(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index].nombreProducto,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )),
            subtitle: Text(
              data[index].precioProducto,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            trailing: Image.network(data[index].imagenProducto),
            onTap: () {
              //pedidoRealizado.add(data[index].nombreProducto);

              /*selectedProduct.add(data[index].nombreProducto);
              productDescription.add(data[index].descripcionProducto);
              productImage.add(data[index].imagenProducto);

              print("Imagen del producto seleccionado: " +
                  productImage.toString());*/

              //productInfo(context, index);

              //showDefaultSnackbar(context);
            },
          );
        });
  }*/

  void showDefaultSnackbar(BuildContext context) {
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
  }

  @override
  Widget build(BuildContext context) {
    /*final logo = Hero(
      tag: "hero",
      child: Image.asset("img/botanaxLogo.png"),
    );*/

    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 100.0,
                  height: 44.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.red,
                      child: Text(
                        'Entradas',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {}),
                ),
                ButtonTheme(
                  minWidth: 100.0,
                  height: 44.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.red,
                      child: Text(
                        'Platillos',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        print("Platillos: " + listaPlatillos.toString());

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext ctx) => Platillos()));
                      }),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 100.0,
                  height: 44.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.red,
                      child: Text(
                        'Bebidas',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {}),
                ),
                ButtonTheme(
                  minWidth: 100.0,
                  height: 44.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.red,
                      child: Text(
                        'Postres',
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                    print("Pedido realizado: " + pedidoRealizado.toString());

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => Carrito()));
                  }),
            )
          ],
        )
      ],
    );
  }

  /*void productInfo(BuildContext context, int productIndex) {
    print("Index del producto seleccionado: " + productIndex.toString());

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(listaPlatillos[productIndex]),
            content: Text(productDescription[productIndex]),
            actions: <Widget>[
              Image.network(productImage[productIndex]),
              FlatButton(
                child: Text("Cerrar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                  child: Text("Agregar al carrito"),
                  onPressed: () {
                    pedidoRealizado.add(selectedProduct[productIndex]);
                    precioProducto.add(productPrice[productIndex]);

                    total += double.parse(productPrice[productIndex]);

                    Navigator.of(context).pop();
                    //showDefaultSnackbar(context);
                  })
            ],
          );
        });
  }*/
}

/*lass Platillos extends StatelessWidget {
  final prod = new ProductosState();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Products>>(
      future: prod.obtenerPlatillos(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Products> data = snapshot.data;
          return prod.buildListaPlatillos(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class Bebidas extends StatelessWidget {
  final prod = new ProductosState();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Products>>(
      future: prod.obtenerBebidas(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Products> data = snapshot.data;
          return prod.buildListaBebidas(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}*/
