import 'package:flutter/material.dart';
import 'MenuLateral.dart';

class Avaliacao extends StatefulWidget {
  @override
  _AvaliacaoState createState() => _AvaliacaoState();
}

class _AvaliacaoState extends State<Avaliacao> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avaliação"),
        centerTitle: true,
      ),
     drawer: MenuLateral(),
      body: Center(
        child: Text("Avalie"),
      )
    );
  }
}
