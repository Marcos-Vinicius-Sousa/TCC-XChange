import 'package:flutter/material.dart';

class Config {

  static List<DropdownMenuItem<String>> getCategorias() {
    List<DropdownMenuItem<String>> itensDropCategorias = [];

    itensDropCategorias.add(
        DropdownMenuItem(child: Text(
            "Categoria", style: TextStyle(
            color: Colors.indigo
        )
        ), value: null,));
    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Automóvel"), value: "auto",));
    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Imóvel"), value: "imóvel",));
    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Eletronicos"), value: "eletro",));
    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Moda"), value: "moda",));
    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Serviços"), value: "serviço",));
    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Esportes"), value: "esportes",));

    return itensDropCategorias;
  }

  static List<DropdownMenuItem<String>> getCidades() {
    List<DropdownMenuItem<String>> itensDropCidades = [];

    itensDropCidades.add(
        DropdownMenuItem(child: Text(
            "Cidades", style: TextStyle(
            color: Colors.indigo
        )
        ), value: null,));


    itensDropCidades.add(
        DropdownMenuItem(child: Text("São Vicente"), value: "São Vicente",)
    );
    itensDropCidades.add(
        DropdownMenuItem(child: Text("Santos"), value: "Santos",)
    );
    itensDropCidades.add(
        DropdownMenuItem(child: Text("Guaruja"), value: "Guaruja",)
    );
    itensDropCidades.add(
        DropdownMenuItem(child: Text("Praia Grande"), value: "Praia Grande",)
    );
    itensDropCidades.add(
        DropdownMenuItem(child: Text("Cubatão"), value: "Cubatão",)
    );

    return itensDropCidades;
  }
}