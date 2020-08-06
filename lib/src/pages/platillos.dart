import 'package:flutter/material.dart';
import 'package:pedidos/src/pages/productos.dart';

class Platillos extends StatefulWidget {
  Platillos({Key key}) : super(key: key);

  @override
  _PlatillosState createState() => _PlatillosState();
}

class _PlatillosState extends State<Platillos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listaPlatillos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listaPlatillos[index],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              )
            ),
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
        }
      ),
    );
  }
}