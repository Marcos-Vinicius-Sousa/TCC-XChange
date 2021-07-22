import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:x_change/views/Avaliacao.dart';
import 'package:x_change/views/Buscar.dart';
import 'package:x_change/views/MeusAnuncios.dart';
import 'package:x_change/views/PedidosTrocas.dart';
import 'package:x_change/views/Perfil.dart';
import 'package:x_change/views/Planos.dart';
import 'package:x_change/views/Sobre.dart';

class Anuncios extends StatefulWidget {
  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {

  List<String> itensMenu = [];

  _escolhaMenuItem(String itemEscolhido){

  }

  Future _verificarUsuarioLogado() async {

    Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
    // recuperando o usuario que esta logado no momento
    Auth.User usuarioLogado = await auth.currentUser;
    if(usuarioLogado != null){

      Navigator.pushReplacementNamed(context,"/");

    }
  }

  _deslogarUsuario() async {

    Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushNamed(context, "/login");
  }

  
  String _emailUsuario = "";
  Future _recuperarEmail() async {
    Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
    Auth.User usuarioLogado = await auth.currentUser;

    setState(() {
      _emailUsuario = usuarioLogado.email;
    });
  }

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

  void meusAnuncios(){

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MeusAnuncios()));
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
  void initState() {
    _recuperarEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(
        title: Text("X-Change"),
      ),
      drawer: Drawer(
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
                leading: Icon(Icons.add),
                title: Text("Meus Anuncios"),
                subtitle:Text("Crie seu Anuncio"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){
                  meusAnuncios();
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
                  _deslogarUsuario();
                },
              ),
            ],
          )
      ),
      body: Center(
        child: Text(_emailUsuario),
      ),
    );
  }
}

