import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:pedidos/src/pages/login.dart';

class Pedidos extends StatefulWidget {
  @override
  PedidosState createState() => new PedidosState();
}

class PedidosState extends State<Pedidos> {
  void realizarPedido() async {
    var url =
        "https://pruebasbotanax.000webhostapp.com/Pedidos/realizarPedido.php";

    final response = await http.post(url, body: {
      "pedido": "Rib eye 300g termino medio",
      "total": 225.toString(),
      "id_c": 1.toString(),
      "nombre": nombreUsuario,
      "telefono": telefonoUsuario,
      "colonia": "Las Cruces",
      "calle": "Ahuatla",
      "numero": "S/N",
      "estatus_p": 0.toString()
    });

    print("Respuesta: " + response.body);
  }

  void sendPush() async {
    var url = "https://pruebasbotanax.000webhostapp.com/Pedidos/push.php";

    final response = await http.post(url, body: {"": ""});

    print("Respuesta: " + response.body);
  }

  @override
  Widget build(BuildContext context) {
    /*final logo = Hero(
      tag: "hero",
      child: Image.asset("img/botanaxLogo.png"),
    );*/

    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                //logo,
                SizedBox(height: 150),
                new ButtonTheme(
                  minWidth: 200.0,
                  height: 100.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: Colors.red,
                    child: Text("Realizar pedido",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      realizarPedido();
                      sendPush();

                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Funciones()),
                      );*/
                    },
                  ),
                )
              ],
            )));
  }
}
