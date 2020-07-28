import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  var list = List();
  int tabIndex = 0;
  List<String> listaPlatillos = new List<String>();

  mostrarPlatillos(int index) async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/getProducts.php";

    final response =
        await http.post(url, body: {"indice_categoria": index.toString()});

    if (response.statusCode == 200) {
      //print("Número de platillos: " + productsData[0]["nombre"])
      if (mounted) {
        setState(() {
          list = json.decode(response.body) as List;
        });
      }
    }

      listaPlatillos.clear();

      for (int i = 0; i < list.length; i++)
        listaPlatillos.add(list[i]["nombre"]);

      print("Lista de platillos: " + listaPlatillos.toString());
    }

  @override
  void initState() {
    mostrarPlatillos(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              final data = list[index];
              return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: Text(data['nombre']),
                subtitle: Text(
                  data['precio'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}