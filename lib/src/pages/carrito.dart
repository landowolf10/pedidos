import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedidos/src/pages/productos.dart';

List<int> listaCantidad = new List<int>();

class Carrito extends StatefulWidget {
  Carrito({Key key}) : super(key: key);

  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  TextEditingController cantidadController = new TextEditingController();
  bool cargando;
  int cantidad = 1, productIndex;

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
                    final price = precioProducto[index];

                    return Dismissible(
                      key: Key(item),
                      onDismissed: (direction) {
                        setState(() {
                          pedidoRealizado.removeAt(index);
                          precioProducto.removeAt(index);

                          total = total - double.parse(price);
                          
                          print("Producto a pedir: " + pedidoRealizado.toString());
                          print("Precio del producto eliminado: " + price.toString());
                          print(total);
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
                            trailing: Text(precioProducto[index]),

                            onTap: () {
                              productIndex = index;

                              setState(()
                              {
                                //productQuantity(context, productIndex);
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
                    print("Pedido: " + pedidoRealizado.toString());
                    print("Lista precios: " + precioProducto.toString());

                    print("Total: " + total.toString());
                  }
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /*void productQuantity(BuildContext context, int productIndex)
  {
    print("Index del producto seleccionado: " + productIndex.toString());

    showDialog(
      context: context,
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text(selectedProduct[productIndex]),
          content: StatefulBuilder(
            builder: (BuildContext context, setState){
              return SingleChildScrollView(
                child:  Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.network(productImage[productIndex]),
                    TextField(
                      controller: cantidadController,
                      keyboardType: TextInputType.numberWithOptions(decimal: false),
                      decoration: InputDecoration(hintText: "Cantidad"),
                    ),
                  ],
                ),
              );
            }
          ), 
          actions: <Widget>[
            FlatButton(
              child: Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Agregar al carrito"),
              onPressed: (){
                
                pedidoRealizado.add(selectedProduct[productIndex]);
                precioProducto.add(productPrice[productIndex]);

                total += double.parse(productPrice[productIndex]);

                Navigator.of(context).pop();
                //showDefaultSnackbar(context);
              }
            )
          ],
        );
      }
    );
  }*/
}