import 'package:flutter/material.dart';
import 'package:x_change/views/Avaliacao.dart';
import 'package:x_change/views/Buscar.dart';
import 'package:x_change/views/PedidosTrocas.dart';
import 'package:x_change/views/Perfil.dart';
import 'package:x_change/views/Planos.dart';
import 'package:x_change/views/Sobre.dart';

class MenuLateral extends StatefulWidget {
  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {

  void avaliar(){

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Avaliacao()));
  }

  void editarPerfil(){

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Perfil()));
  }

  void trocar(){

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PedidosTrocas()));
  }

  void editarPlanos(){

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Planos()));
  }

  void buscar(){

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Buscar()));
  }

  void sobre(){

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Sobre()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:ListView(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Perfil"),
              subtitle:Text("Editar perfil"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                editarPerfil();
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text("Buscar"),
              subtitle:Text("produtos ou serviços"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                buscar();
              },
            ),
            ListTile(
              leading: Icon(Icons.find_replace),
              title: Text("Atualizar Plano"),
              subtitle:Text("mudar plano"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                editarPlanos();
              },
            ),
            ListTile(
              leading: Icon(Icons.timeline),
              title: Text("Avaliações"),
              subtitle:Text("suas avaliações"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                avaliar();
              },
            ),
            ListTile(
              leading: Icon(Icons.build),
              title: Text("Sobre"),
              subtitle:Text("Conheça xChange"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                sobre();
              },
            ),
            ListTile(
              leading: Icon(Icons.transit_enterexit),
              title: Text("Sair"),
              subtitle:Text("Deslogar"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){

              },
            ),
          ],
        )
    );
  }
}
