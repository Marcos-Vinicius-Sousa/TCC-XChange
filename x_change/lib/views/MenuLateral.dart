import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:firebase_core/firebase_core.dart';


import 'package:x_change/views/MeusAnuncios.dart';
import 'package:x_change/views/Perfil.dart';
import 'package:x_change/views/Sobre.dart';
import 'Anuncios.dart';

class MenuLateral extends StatefulWidget {
  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {


  void editarPerfil() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Perfil()));
  }


  void sobre() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Sobre()));
  }

  void home() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Anuncios()));
  }

  void meusAnuncios() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MeusAnuncios()));
  }

  _deslogarUsuario() async {
    Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              subtitle: Text("Pagina Inicial"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                home();
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Perfil"),
              subtitle: Text("Editar perfil"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                editarPerfil();
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Meus Anuncios"),
              subtitle: Text("Crie seu Anuncio"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                meusAnuncios();
              },
            ),

            ListTile(
              leading: Icon(Icons.build),
              title: Text("Sobre"),
              subtitle: Text("Conheça xChange"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                sobre();
              },
            ),
            ListTile(
              leading: Icon(Icons.transit_enterexit),
              title: Text("Sair"),
              subtitle: Text("Deslogar"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                _deslogarUsuario();
              },
            ),
          ],
        )
    );
  }
}
