import 'package:flutter/material.dart';
import 'package:x_change/views/MenuLateral.dart';

class Buscar extends StatefulWidget {
  @override
  _BuscarState createState() => _BuscarState();
}

class _BuscarState extends State<Buscar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pesquisar"),
          centerTitle: true,
        ),
        drawer: MenuLateral(),
        body: Center(
          child: Text("Pesquisar"),
        )
    );
  }
}
