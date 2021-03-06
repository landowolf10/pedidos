import 'package:flutter/material.dart';
import 'package:pedidos/src/models/products_model.dart';
import 'package:pedidos/src/pages/carrito.dart';
import 'package:pedidos/src/pages/productos.dart';

class Platillos extends StatefulWidget {
  Platillos({Key key}) : super(key: key);

  @override
  _PlatillosState createState() => _PlatillosState();
}

class _PlatillosState extends State<Platillos> {
  bool cargando;
  int dishIndex;
  List<String> listaPlatillos = new List<String>();
  List<String> precioPlatillos = new List<String>();

  ProductosState prod = new ProductosState();

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
                      child: FutureBuilder<List<Products>>(
                        future: prod.obtenerPlatillos(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();

                          var values = snapshot.data;

                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                listaPlatillos
                                    .add(values[index].nombreProducto);

                                precioPlatillos.add(
                                    values[index].precioProducto.toString());

                                cantidadProducto.add(1);

                                return ListTile(
                                  title: Text(values[index].nombreProducto,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      )),
                                  subtitle: Text(
                                      values[index].precioProducto.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      )),
                                  trailing: Image.network(
                                      values[index].imagenProducto),
                                  onTap: () {
                                    dishIndex = index;

                                    productInfo(context);
                                    //pedidoRealizado.add(data[index].nombreProducto);
                                    //showDefaultSnackbar(context);
                                  },
                                );
                              });
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

  void productInfo(BuildContext context) {
    print("Índice del platillo: " + dishIndex.toString());

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(listaPlatillos[dishIndex]),
            //content: Text(descripcionPlatillo[productIndex]),
            actions: <Widget>[
              //Image.network(imagenPlatillo[productIndex]),
              FlatButton(
                child: Text("Cerrar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                  child: Text("Agregar al carrito"),
                  onPressed: () {
                    pedidoRealizado.add(listaPlatillos[dishIndex]);
                    precioProducto.add(precioPlatillos[dishIndex]);

                    total += double.parse(precioPlatillos[dishIndex]);

                    Navigator.of(context).pop();

                    //Dialogos dialogos = new Dialogos();

                    //dialogos.showCartMessage(context);
                    //showDefaultSnackbar(context);
                  })
            ],
          );
        });
  }
}
