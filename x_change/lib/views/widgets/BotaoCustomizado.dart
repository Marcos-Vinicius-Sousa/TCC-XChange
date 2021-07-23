import 'package:flutter/material.dart';

class BotaoCustomizado extends StatelessWidget {

  final String texto;
  final Color corTexto;
  final VoidCallback onPressed;

  BotaoCustomizado({
    @required this.texto,
    this.corTexto = Colors.white,
    this.onPressed

});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        this.texto,
        style: TextStyle(color: corTexto, fontSize: 20),
      ),
      color: Colors.deepOrange,
      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32)
      ),
      onPressed: this.onPressed
    );
}
}
