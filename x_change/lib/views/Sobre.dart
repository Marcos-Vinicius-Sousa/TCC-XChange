import 'package:flutter/material.dart';
import 'package:x_change/views/MenuLateral.dart';

class Sobre extends StatefulWidget {
  @override
  _SobreState createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sobre"),
          centerTitle: true,
        ),
        drawer: MenuLateral(),
        body: Center(
          child: Text("Conheça xChange"),
        )
    );
  }
}
