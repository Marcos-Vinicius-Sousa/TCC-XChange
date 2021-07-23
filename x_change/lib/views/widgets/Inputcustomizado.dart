import 'package:flutter/material.dart';

class Inputcustomizado extends StatelessWidget {

  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;

  Inputcustomizado({
    @required this.controller,
    @required this.hint,
    this.obscure = false,
    this.autofocus = false,
    this.type = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: this.obscure,
      controller: this.controller,
      autofocus: this.autofocus,
      keyboardType: this.type,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32))),
    );
  }
}
