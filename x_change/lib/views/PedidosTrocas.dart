import 'package:flutter/material.dart';
import 'package:x_change/views/MenuLateral.dart';

class PedidosTrocas extends StatefulWidget {
  @override
  _PedidosTrocasState createState() => _PedidosTrocasState();
}

class _PedidosTrocasState extends State<PedidosTrocas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pedidos"),
          centerTitle: true,
        ),
        drawer: MenuLateral(),
        body: Center(
          child: Text("Pedidos de Trocas"),
        )
    );
  }
}
