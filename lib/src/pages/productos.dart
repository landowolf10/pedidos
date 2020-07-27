import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:pedidos/src/models/products_model.dart';

class Productos extends StatefulWidget {
  @override
  ProductosState createState() => new ProductosState();
}

class ProductosState extends State<Productos> with SingleTickerProviderStateMixin {
  TabController tabController;
  int tabIndex = 0;
  List<String> listaProductos = new List<String>();

  @override
  void initState() {
    //tabIndex = 0;

    mostrarProductos(tabIndex);

    //tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    print(tabIndex);

    super.initState();
  }

  mostrarProductos(int index) async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getProducts.php";

    final response = await http.post(url, body: {
      "indice_categoria": index.toString()
    });

    if(response.statusCode == 200)
    {

      //print("Número de platillos: " + productsData[0]["nombre"]); 
      print("Respuesta: " + response.body);

      List<dynamic> listaProductos = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();

      print(listaProductos[0]);

      //return listaProductos.map((product) => new Products.fromJson(product)).toList();
    }
  }

  /*ListView productsListView(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        print(data[index].nombreProducto + " " + data[index].precioProducto);
        return _tile(data[index].nombreProducto, data[index].precioProducto);
      }
    );
  }

  ListTile _tile(String title, String subtitle) => ListTile(
    title: Text(title,
    style: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
    )),
    subtitle: Text(subtitle)
  );*/

  Widget _buildList(data) {
  return ListView.builder(
    //itemBuilder: (_, i) => ListTile(title: Text("${i}")),

    itemCount: data.length,
    itemBuilder: (context, index) => ListTile(title: Text(data[index].nombreProducto))
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
            child: Column(
              children: <Widget>[
                Flexible(
                  child: DefaultTabController(
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
                      ),
                      body: TabBarView(
                        children: [
                          /*FutureBuilder<List<Products>>(
                            future: mostrarProductos(tabIndex),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Products> data = snapshot.data;

                                return _buildList(data);
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          )*/
                          /*ListView(
                            children: <Widget>[
                              ListTile(title: Text("Entradas")),
                              ListTile(title: Text("Platillos")),
                              ListTile(title: Text("Bebidas")),
                              ListTile(title: Text("Postres")),
                            ],
                          ),*/
                          Text("Entradas"),
                          Text("Platillos fuertes"),
                          Text("Bebidas"),
                          Text("Postres")

                          //_buildList(data)
                        ],
                      )
                    )
                  )
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 44.0,
                  child: RaisedButton
                  (
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.red,
                    child: Text(
                      'Ir al carrito',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),  
                    onPressed: (){
                      
                    }
                  ),
                )
              ],
            ),
          ),
        ],
      ),
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