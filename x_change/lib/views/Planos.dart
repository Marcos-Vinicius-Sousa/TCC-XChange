import 'package:flutter/material.dart';
import 'package:x_change/views/MenuLateral.dart';

class Planos extends StatefulWidget {
  @override
  _PlanosState createState() => _PlanosState();
}

class _PlanosState extends State<Planos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Planos"),
          centerTitle: true,
        ),
        drawer: MenuLateral(),
        body: Center(
          child: Text("Alterar Plano"),
        )
    );
  }
}
