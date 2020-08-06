import 'package:flutter/material.dart';
import 'package:pedidos/src/pages/productos.dart';

class Platillos extends StatefulWidget {
  Platillos({Key key}) : super(key: key);

  @override
  _PlatillosState createState() => _PlatillosState();
}

class _PlatillosState extends State<Platillos> {
  bool cargando;

  @override
  void initState() {
    if (listaPlatillos.isEmpty)
      cargando = true;
    else
      cargando = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: ListView(
              children: <Widget>[
                //logo,
                SizedBox(height: 20),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 225,
                      child: cargando
                          ? Container(
                              child: Text("No hay platillos en el menú",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                  )))
                          : ListView.builder(
                              itemCount: listaPlatillos.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(listaPlatillos[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      )),
                                  /*subtitle: Text(data[index].precioProducto,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                        ),
                        trailing: Image.network(data[index].imagenProducto),*/
                                  onTap: () {
                                    print("Index: " + index.toString());
                                    //print("Productos seleccionados" + selectedProduct.toString());

                                    //productInfo(context, index);

                                    //pedidoRealizado.add(data[index].nombreProducto);
                                    //showDefaultSnackbar(context);
                                  },
                                );
                              }),
                    )
                  ],
                )
              ],
            )));
  }
}
