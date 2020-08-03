import 'package:flutter/material.dart';
import 'package:pedidos/src/pages/productos.dart';

class Carrito extends StatefulWidget {
  Carrito({Key key}) : super(key: key);

  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  bool cargando;

  @override
  void initState() {
    if(pedidoRealizado.isEmpty)
      cargando = true;
    else
      cargando = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 400,
                child: cargando ? Container(child: Text(
                  "Carrito vacío",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  )
                )) : 
                ListView.builder(
                  itemCount: pedidoRealizado.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    final item = pedidoRealizado[index];

                    return Dismissible(
                      key: Key(item),
                      onDismissed: (direction) {
                        setState(() {
                          pedidoRealizado.removeAt(index);

                          print(pedidoRealizado);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            'Eliminar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      child: Center(
                        child: new Center(
                          child: ListTile(
                            title: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    pedidoRealizado[index],
                                    style: TextStyle(
                                      fontSize: 16, color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(()
                              {

                              });
                            },
                          ),
                        )
                      ),
                    );
                  },
                ),
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
                      'Realizar pedido',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  onPressed: (){
                    print(pedidoRealizado);
                    print(precioProducto);
                  }
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}