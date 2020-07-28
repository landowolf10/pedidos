import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:pedidos/src/models/products_model.dart';

class Productos extends StatefulWidget {
  @override
  ProductosState createState() => new ProductosState();
}

class ProductosState extends State<Productos>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int tabIndex = 0;

  List<dynamic> listaProductos;

  List<Products> listOfProducts;

  List<String> listaEntradas = new List<String>();
  List<String> listaPlatillos = new List<String>();
  List<String> listaBebidas = new List<String>();
  List<String> listaPostres = new List<String>();

  @override
  void initState() {
    //tabIndex = 0;

    //initialization();
    obtenerPlatillos(1);

    tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    //print(tabIndex);

    super.initState();
  }

  /*initialization() async {
    await mostrarPlatillos(1);
  }*/

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

      print(listaEntradas);
    }
  }

  Future<List<Products>> obtenerPlatillos(int index) async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getProducts.php";

    final response =
        await http.post(url, body: {"indice_categoria": index.toString()});

    if (response.statusCode == 200) {
      print(response.body);
      //print("Número de platillos: " + productsData[0]["nombre"])
      listaProductos = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      listOfProducts = listaProductos.map<Products>((json) {
        return Products.fromJson(json);
      }).toList();
    }
  }

  mostrarPlatillos() {
    //listaPlatillos.clear();

    print("Número de platillos: " + listaPlatillos.length.toString());

    for (int i = 0; i < listaProductos.length; i++)
      listaPlatillos.add(listaProductos[i]["nombre"]);

    print(listaPlatillos);
  }

  mostrarBebidas(int index) async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getProducts.php";

    final response =
        await http.post(url, body: {"indice_categoria": index.toString()});

    if (response.statusCode == 200) {
      //print("Número de platillos: " + productsData[0]["nombre"])
      List<dynamic> listaProductos = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      listaBebidas.clear();

      for (int i = 0; i < listaProductos.length; i++)
        listaBebidas.add(listaProductos[i]["nombre"]);

      print(listaBebidas);
    }
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

      print(listaPostres);
    }
  }

  Widget _buildList({String key, List<String> producto}) {
    //print("Número de platillos: " + listaPlatillos.length.toString());

    return FutureBuilder<List<Products>>(
      future: obtenerPlatillos(tabIndex),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (var i = 0; i < snapshot.data.length; i++)
            return Text(snapshot.data[i].nombreProducto);
          //return Text(snapshot.data.posts[1].name);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner
        return CircularProgressIndicator();
      },
    );

    /*return ListView.builder(
      key: PageStorageKey(key),
      itemCount: listaPlatillos.length,
      itemBuilder: (_, index) => ListTile(title: Text(producto[index])),
    );*/
  }

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

                    if (tabIndex == 1) mostrarPlatillos();

                    if (tabIndex == 2) mostrarBebidas(tabIndex);

                    if (tabIndex == 3) mostrarPostres(tabIndex);

                    print(tabIndex);
                  },
                ),
                Expanded(
                  child: TabBarView(controller: tabController, children: [
                    Platillos(),
                    _buildList(key: "key1", producto: listaPlatillos),
                    _buildList(key: "key2", producto: listaBebidas),
                    Platillos()
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
      /*body: ListView(
        children: <Widget>[
          Container(
            height: 350.0,
            child: Column(
              children: <Widget>[
                Flexible(
                    child: DefaultTabController(
                        length: 4,
                        child: Scaffold(
                            appBar: AppBar(
                              title: Center(child: Text('Arme su pedido')),
                              bottom: TabBar(
                                controller: tabController,
                                tabs: [
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

                                  if (tabIndex == 1) mostrarPlatillos(tabIndex);

                                  if (tabIndex == 2) mostrarBebidas(tabIndex);

                                  if (tabIndex == 3) mostrarPostres(tabIndex);

                                  print(tabIndex);
                                },
                              ),
                            ),
                            body: TabBarView(
                              controller: tabController,
                              children: [
                                Column(
                                  children: <Widget>[
                                    ListView(
                                      children: <Widget>[
                                        Platillos(),
                                        Platillos(),
                                        Platillos(),
                                        Platillos(),
                                      ],
                                    ),
                                  ],
                                )
                                /*Text("Entradas"),
                                Text(listaPlatillos.toString()),
                                Text("Bebidas"),
                                Text("Postres")*/
                              ],
                            )))),
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
                      onPressed: () {}),
                )
              ],
            ),
          ),
        ],
      ),*/
    );

    /*return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          
          appBar: AppBar(
            title: Center(child:Text('Arme su pedido')),
            bottom: TabBar(
              tabs: [
                Tab(text: "Entradas", ),
                Tab(text: "Platillos",),
                Tab(text: "Bebidas",),
                Tab(text: "Postres", ),
              ],
              onTap: (value){
                tabIndex = value;

                //if(tabIndex == 1)
                  mostrarProductos(tabIndex);

                /*if(tabIndex == 2)
                  mostrarProductos(tabIndex);*/

                print(tabIndex);
              },
            ),
            // title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Text("Entradas"),
              Text("Platillos fuertes"),
              Text("Bebidas"),
              Text("Postres")
            ],
          ),
          
        ),
      ),
    );*/
  }
}

class Platillos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        Card(
          child: Container(
            height: 200.0,
            alignment: Alignment.center,
            child: Text("Entradas"),
          ),
        ),
        Card(
          child: Container(
            height: 200.0,
            alignment: Alignment.center,
            child: Text("Platillos"),
          ),
        ),
        Card(
          child: Container(
            height: 200.0,
            alignment: Alignment.center,
            child: Text("Bebidas"),
          ),
        ),
        Card(
          child: Container(
            height: 200.0,
            alignment: Alignment.center,
            child: Text("Postres"),
          ),
        ),
      ],
    );
  }
}
