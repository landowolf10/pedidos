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

  ProductosState prod = new ProductosState();

  /*@override
  void initState() {
    if (listaBebidas.isEmpty)
      cargando = true;
    else
      cargando = false;

    super.initState();
  }*/

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
                      child: /*cargando
                          ? Container(
                              child: Text("No hay bebidas en el menú",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                  )))
                          : */
                            FutureBuilder(
                              future: prod.obtenerBebidas(),
                              builder: (BuildContext context, AsyncSnapshot<List<Products>> snapshot) {
                                if (!snapshot.hasData)
                                  return CircularProgressIndicator();

                                var values = snapshot.data;

                                return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index){
                                    return ListTile(
                                      title: Text(values[index].nombreProducto,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                          )),
                                      subtitle: Text(values[index].precioProducto,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                          )),
                                      trailing: Image.network(values[index].imagenProducto),
                                      onTap: () {
                                        productInfo(context, index);
                                        //pedidoRealizado.add(data[index].nombreProducto);
                                        //showDefaultSnackbar(context);
                                      },
                                    );
                                  }
                                );
                              },
                            )
                          /*ListView.builder(
                              itemCount: listaBebidas.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(listaBebidas[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      )),
                                  subtitle: Text(listaPreciosBebidas[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      )),
                                  trailing: Image.network(imagenBebida[index]),
                                  onTap: () {
                                    productInfo(context, index);
                                    //pedidoRealizado.add(data[index].nombreProducto);
                                    //showDefaultSnackbar(context);
                                  },
                                );
                              })*/,
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
    print("Index del producto seleccionado: " + productIndex.toString());

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(listaBebidas[productIndex]),
            content: Text(descripcionBebida[productIndex]),
            actions: <Widget>[
              Image.network(imagenBebida[productIndex]),
              FlatButton(
                child: Text("Cerrar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                  child: Text("Agregar al carrito"),
                  onPressed: () {
                    pedidoRealizado.add(listaBebidas[productIndex]);
                    precioProducto.add(precioBebida[productIndex]);

                    total += double.parse(precioBebida[productIndex]);

                    Navigator.of(context).pop();
                    //showDefaultSnackbar(context);
                  })
            ],
          );
        });
  }
}
