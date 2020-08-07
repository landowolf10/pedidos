import 'package:flutter/material.dart';
import 'package:pedidos/src/pages/productos.dart';

class Bebidas extends StatefulWidget {
  Bebidas({Key key}) : super(key: key);

  @override
  _BebidasState createState() => _BebidasState();
}

class _BebidasState extends State<Bebidas> {
  bool cargando;

  @override
  void initState() {
    if (listaBebidas.isEmpty)
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
                              child: Text("No hay bebidas en el menú",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                  )))
                          : ListView.builder(
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
                                    )
                                  ),
                                  trailing: Image.network(imagenBebida[index]),
                                  onTap: () {
                                    print("Index: " + index.toString());
                                    //print("Productos seleccionados" + selectedProduct.toString());

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
                            'Regresar al menú',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onPressed: () {
                            print("Pedido realizado: " + pedidoRealizado.toString());

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext ctx) => Productos()));
                          }),
                    )
                  ],
                )
              ],
            )));
  }

  void productInfo(BuildContext context, int productIndex)
  {
    print("Index del producto seleccionado: " + productIndex.toString());

    showDialog(
      context: context,
      builder: (BuildContext context)
      {
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
              onPressed: (){
                
                //pedidoRealizado.add(selectedProduct[productIndex]);
                //precioProducto.add(productPrice[productIndex]);

                //total += double.parse(productPrice[productIndex]);

                Navigator.of(context).pop();
                //showDefaultSnackbar(context);
              }
            )
          ],
        );
      }
    );
  }
}
