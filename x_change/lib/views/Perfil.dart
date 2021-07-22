import 'package:flutter/material.dart';
import 'package:x_change/views/MenuLateral.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Perfil"),
          centerTitle: true,
        ),
        drawer: MenuLateral(),
        body: Center(
          child: Text("Editar Perfil"),
        )
    );
  }
}
