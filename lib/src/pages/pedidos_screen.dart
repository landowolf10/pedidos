import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Pedidos extends StatefulWidget {
  @override
  PedidosState createState() => new PedidosState();
}

class PedidosState extends State<Pedidos> {
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
                    onPressed: () {
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
