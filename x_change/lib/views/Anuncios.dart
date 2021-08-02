import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:x_change/model/Anuncio.dart';
import 'package:x_change/util/Config.dart';
import 'package:x_change/views/MenuLateral.dart';
import 'package:x_change/views/widgets/itemAnuncio.dart';


class Anuncios extends StatefulWidget {
  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {

  String _itemSelecionadoCidade;
  String _itemSelecionadoCategoria;
  List<DropdownMenuItem<String>> _listaItensCidades;
  List<DropdownMenuItem<String>> _listaItensCategorias;
  final _controller = StreamController<QuerySnapshot>.broadcast();


  Future _verificarUsuarioLogado() async {
    Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
    // recuperando o usuario que esta logado no momento
    Auth.User usuarioLogado = await auth.currentUser;
    if (usuarioLogado != null) {
      Navigator.pushReplacementNamed(context, "/");
    }
  }

  //String _emailUsuario = "";

 /* Future _recuperarEmail() async {
    Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
    Auth.User usuarioLogado = await auth.currentUser;

    setState(() {
      _emailUsuario = usuarioLogado.email;
    });
  } */

  _carregarItensDropdown() {
    _listaItensCategorias = Config.getCategorias();
    _listaItensCidades = Config.getCidades();
  }

  Future<Stream<QuerySnapshot>> _adicionarListenerAnuncios() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("anuncios")
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  @override
  void initState() {
    _carregarItensDropdown();
    //_recuperarEmail();
    _adicionarListenerAnuncios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(
        title: Text("X-Change"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        shadowColor: Colors.indigoAccent,
      ),
      drawer: MenuLateral(),
      body: Center(
        child: Column(children: <Widget>[

          Row(children: <Widget>[

            Expanded(
              child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButton(
                        iconEnabledColor: Colors.blue,
                        value: _itemSelecionadoCidade,
                        items: _listaItensCidades,
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black
                        ),
                        onChanged: (cidade) {
                          setState(() {
                            _itemSelecionadoCidade = cidade;
                          });
                        }
                    ),
                  )
              ),
            ),

            Container(
              color: Colors.green[200],
              width: 2,
              height: 60,
            ),

            Expanded(
              child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButton(
                        iconEnabledColor: Colors.blue,
                        value: _itemSelecionadoCategoria,
                        items: _listaItensCategorias,
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black
                        ),
                        onChanged: (categoria) {
                          setState(() {
                            _itemSelecionadoCategoria = categoria;
                          });
                        }
                    ),
                  )
              ),
            )

          ],),

          StreamBuilder(
            stream: _controller.stream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                case ConnectionState.done:
                  QuerySnapshot querySnapshot = snapshot.data;
                  if (querySnapshot.docs.length == 0) {
                    return Container(
                      padding: EdgeInsets.all(25),
                      child: Text("Nenhum anúncio! ",
                        style: TextStyle(
                            fontSize: 20,
                            // ignore: missing_return, missing_return
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: querySnapshot.docs.length,
                        itemBuilder: (_,indice){
                          List<DocumentSnapshot> anuncios = querySnapshot.documents
                              .toList();
                          DocumentSnapshot documentSnapshot = anuncios[indice];
                          Anuncio anuncio = Anuncio.fromDocumentSnapshot(
                              documentSnapshot);

                          return ItemAnuncio(
                              anuncio: anuncio,
                          onTapIem: (){

                          }
                          );
                          }
                        ),
                  );
              }

              return Container();
            },
          )
        ],
        ),
      ),
    );
  }
}

