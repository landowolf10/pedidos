import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pedidos/src/models/products_model.dart';

String pedido = "";

class Productos extends StatefulWidget {
  @override
  ProductosState createState() => new ProductosState();
}

class ProductosState extends State<Productos>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int tabIndex = 0, elements = 0;

  List<Products> listOfProducts;

  List<String> listaEntradas = new List<String>();
  List<String> listaPlatillos = new List<String>();
  List<String> listaBebidas = new List<String>();
  List<String> listaPostres = new List<String>();

  @override
  void initState() {
    //tabIndex = 0;

    initialization();
    //mostrarPlatillos(1);
    //mostrarBebidas(2);

    //print("Lista de productos: " + listOfProducts.toString());

    tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    //print(tabIndex);

    super.initState();
  }

  initialization() async {
    await obtenerPlatillos();
    await obtenerBebidas();
  }

  getElement() {
    if (tabIndex == 0) elements = listaEntradas.length;

    if (tabIndex == 1) {
      elements = listaPlatillos.length;
      //buildListaPlatillos(key: "key1", producto: listaPlatillos, elementos: elements);
    }

    if (tabIndex == 2) {
      if (listaBebidas.length == 1)
        elements = 0;
      else {
        elements = listaBebidas.length;
        //buildListaPlatillos(key: "key1", producto: listaBebidas, elementos: elements);
      }
    }

    if (tabIndex == 3) elements = listaPostres.length;

    print("Cantidad de elementos: " + elements.toString());
  }

  mostrarEntradas(int index) async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getProducts.php";

    final response =
        await http.post(url, body: {"indice_categoria": index.toString()});

    if (response.statusCode == 200) {
      //print("Número de platillos: " + productsData[0]["nombre"])
      List<dynamic> listaProductos = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      listaEntradas.clear();

      for (int i = 0; i < listaProductos.length; i++)
        listaEntradas.add(listaProductos[i]["nombre"]);

      getElement();

      print(listaEntradas);
    }
  }

  Future<List<Products>> obtenerPlatillos() async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getPlatillos.php";

    final response = await http.get(url);

    print(response.body);

    List jsonResponse;

    if (response.statusCode == 200) {
      //setState(() {
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
      } else {
        throw Exception('Failed to load products from API');
      }
      //});
    }

    return jsonResponse
        .map((platillo) => new Products.fromJson(platillo))
        .toList();
  }

  Future<List<Products>> obtenerBebidas() async {
    var url = "https://pruebasbotanax.000webhostapp.com/Pedidos/getBebidas.php";

    final response = await http.get(url);

    print(response.body);

    List jsonResponse;

    if (response.statusCode == 200) {
      //setState(() {
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
      } else {
        throw Exception('Failed to load products from API');
      }
      //});
    }

    return jsonResponse.map((bebida) => new Products.fromJson(bebida)).toList();
  }

  mostrarPostres(int index) async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getProducts.php";

    final response =
        await http.post(url, body: {"indice_categoria": index.toString()});

    if (response.statusCode == 200) {
      //print("Número de platillos: " + productsData[0]["nombre"])
      List<dynamic> listaProductos = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      listaPostres.clear();

      for (int i = 0; i < listaProductos.length; i++)
        listaPostres.add(listaProductos[i]["nombre"]);

      getElement();

      print(listaPostres);
    }
  }

  Widget buildListaPlatillos(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index].nombreProducto,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )),
            onTap: () {
              pedido = pedido + ", " + data[index].nombreProducto;

              showDefaultSnackbar(context);
              /*Fluttertoast.showToast(
                  msg: "Producto agregado correctamente",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM);*/
            },
          );
        });
  }

  Widget buildListaBebidas(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index].nombreProducto,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )),
            onTap: () {
              pedido = pedido + " " + data[index].nombreProducto;
            },
          );
        });
  }

  void showDefaultSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Producto agregado al carrito"),
        action: SnackBarAction(
          label: 'Click Me',
          onPressed: () {},
        ),
      ),
    );
  }

  /*ListTile _tile(String title, /*String subtitle*/) => ListTile(
    title: Text(title,
    style: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
    )),
    //subtitle: Text(subtitle),
    onTap: (){
      setState(() {
        
      });
    },
  );*/

  @override
  Widget build(BuildContext context) {
    /*final logo = Hero(
      tag: "hero",
      child: Image.asset("img/botanaxLogo.png"),
    );*/

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 350.0,
            color: Colors.blue,
            child: Column(
              children: <Widget>[
                TabBar(
                  unselectedLabelColor: Colors.blue[100],
                  indicator: BoxDecoration(color: Colors.lightBlue),
                  controller: tabController,
                  tabs: <Widget>[
                    Tab(
                      text: "Entradas",
                    ),
                    Tab(
                      text: "Platillos",
                    ),
                    Tab(
                      text: "Bebidas",
                    ),
                    Tab(
                      text: "Postres",
                    ),
                  ],
                  onTap: (value) {
                    tabIndex = value;

                    if (tabIndex == 0) mostrarEntradas(tabIndex);

                    if (tabIndex == 1) Platillos();

                    if (tabIndex == 2) Bebidas();

                    if (tabIndex == 3) mostrarPostres(tabIndex);

                    print(tabIndex);
                  },
                ),
                Expanded(
                  child: TabBarView(controller: tabController, children: [
                    Platillos(),
                    Platillos(),
                    Bebidas(),
                    Platillos()
                  ]),
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
                        print("Pedido realizado: " + pedido);
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Platillos extends StatelessWidget {
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
}
