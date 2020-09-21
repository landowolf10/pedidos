import 'package:flutter/material.dart';
import 'package:pedidos/src/models/products_model.dart';
import 'package:pedidos/src/pages/carrito.dart';
import 'package:pedidos/src/pages/productos.dart';

class Bebidas extends StatefulWidget {
  Bebidas({Key key}) : super(key: key);

  @override
  _BebidasState createState() => _BebidasState();
}

class _BebidasState extends State<Bebidas> {
  bool cargando;
  int drinkIndex;
  List<String> listaBebidas = new List<String>();
  List<String> precioBebidas = new List<String>();

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
                      child: FutureBuilder(
                        future: prod.obtenerBebidas(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Products>> snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();

                          var values = snapshot.data;

                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                listaBebidas.add(values[index].nombreProducto);

                                //precioBebidas.add(values[index].precioProducto);

                                cantidadProducto.add(1);

                                return ListTile(
                                  title: Text(values[index].nombreProducto,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      )),
                                  /*subtitle: Text(values[index].precioProducto,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      )),*/
                                  trailing: Image.network(
                                      values[index].imagenProducto),
                                  onTap: () {
                                    drinkIndex = index;

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
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(listaBebidas[drinkIndex]),
            //content: Text(descripcionBebida[productIndex]),
            actions: <Widget>[
              //Image.network(imagenBebida[productIndex]),
              FlatButton(
                child: Text("Cerrar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                  child: Text("Agregar al carrito"),
                  onPressed: () {
                    pedidoRealizado.add(listaBebidas[drinkIndex]);
                    precioProducto.add(precioBebidas[drinkIndex]);

                    total += double.parse(precioBebidas[drinkIndex]);

                    Navigator.of(context).pop();
                    //showDefaultSnackbar(context);
                  })
            ],
          );
        });
  }
}
