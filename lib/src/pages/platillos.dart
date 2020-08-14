import 'package:flutter/material.dart';
import 'package:pedidos/src/pages/carrito.dart';
import 'package:pedidos/src/pages/dialogos.dart';
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
                      height: 500,
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
                                  subtitle: Text(listaPreciosPlatillos[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      )),
                                  trailing:
                                      Image.network(imagenPlatillo[index]),
                                  onTap: () {
                                    productInfo(context, index);
                                    //pedidoRealizado.add(data[index].nombreProducto);
                                    //showDefaultSnackbar(context);
                                  },
                                );
                              }),
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext ctx) => Carrito()));
                          }),
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
                            'Regresar al menú',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext ctx) =>
                                        Productos()));
                          }),
                    )
                  ],
                )
              ],
            )));
  }

  void productInfo(BuildContext context, int productIndex) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(listaPlatillos[productIndex]),
            content: Text(descripcionPlatillo[productIndex]),
            actions: <Widget>[
              Image.network(imagenPlatillo[productIndex]),
              FlatButton(
                child: Text("Cerrar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                  child: Text("Agregar al carrito"),
                  onPressed: () {
                    pedidoRealizado.add(listaPlatillos[productIndex]);
                    precioProducto.add(precioPlatillo[productIndex]);

                    total += double.parse(precioPlatillo[productIndex]);

                    Navigator.of(context).pop();

                    Dialogos dialogos = new Dialogos();

                    dialogos.showCartMessage(context);
                    //showDefaultSnackbar(context);
                  })
            ],
          );
        });
  }
}
