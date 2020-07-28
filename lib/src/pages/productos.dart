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
  int tabIndex = 0, elements = 0;

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
    mostrarPlatillos(1);
    mostrarBebidas(2);

    //print("Lista de productos: " + listOfProducts.toString());

    tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    //print(tabIndex);

    super.initState();
  }

  /*initialization() async {
    await mostrarPlatillos(1);
  }*/

  getElement(){
    if(tabIndex == 0)
      elements = listaEntradas.length;
      
    if(tabIndex == 1)
      elements = listaPlatillos.length;

    if(tabIndex == 2)
      elements = listaBebidas.length;

    if(tabIndex == 3)
      elements = listaPostres.length;

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

  mostrarPlatillos(int index) async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getProducts.php";

    final response =
        await http.post(url, body: {"indice_categoria": index.toString()});


    print(response.body);

    if (response.statusCode == 200) {
      //print("Número de platillos: " + productsData[0]["nombre"])
      List<dynamic> listaProductos = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      setState(() {
        int counter = 0;
        listaPlatillos.clear();

        for (int i = 0; i < listaProductos.length; i++)
          if(listaProductos[i]["categoria"] == "Platillo")
            counter++;

        print(counter);

        for (int i = 0; i < counter; i++)
          listaPlatillos.add(listaProductos[i]["nombre"]);

        getElement();

        print("Lista de platillos: " + listaPlatillos.toString());
      });
    }
  }

  mostrarBebidas(int index) async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getProducts.php";

    final response =
        await http.post(url, body: {"indice_categoria": index.toString()});

    print(response.body);

    if (response.statusCode == 200) {
      //print("Número de platillos: " + productsData[0]["nombre"])
      List<dynamic> listaProductos = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      int counter = 0;
      listaBebidas.clear();

      for (int i = 0; i < listaProductos.length; i++)
        if(listaProductos[i]["categoria"] == "Bebida")
          counter++;

      print(counter);

      for (int i = 0; i < counter; i++)
        listaBebidas.add(listaProductos[i]["nombre"]);

      getElement();

      print("Lista de bebidas: " + listaBebidas.toString());
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

      getElement();

      print(listaPostres);
    }
  }

  Widget _buildList({String key, List<String> producto, int elementos}) {
    return ListView.builder(
      key: PageStorageKey(key),
      itemCount: elementos,
      itemBuilder: (_, index) => ListTile(title: Text(producto[index])),
    );
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

                    if (tabIndex == 1) mostrarPlatillos(tabIndex);

                    if (tabIndex == 2) mostrarBebidas(tabIndex);

                    if (tabIndex == 3) mostrarPostres(tabIndex);

                    print(tabIndex);
                  },
                ),
                Expanded(
                  child: TabBarView(controller: tabController, children: [
                    Platillos(),
                    _buildList(key: "key1", producto: listaPlatillos, elementos: elements),
                    _buildList(key: "key2", producto: listaBebidas, elementos: elements),
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
                      onPressed: () {}),
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
