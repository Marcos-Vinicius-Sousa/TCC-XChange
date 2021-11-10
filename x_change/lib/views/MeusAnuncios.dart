import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:x_change/model/Anuncio.dart';
import 'package:x_change/views/MenuLateral.dart';
import 'package:x_change/views/widgets/itemAnuncio.dart';

class MeusAnuncios extends StatefulWidget {
  @override
  _MeusAnunciosState createState() => _MeusAnunciosState();
}

class _MeusAnunciosState extends State<MeusAnuncios> {

  final _controller = StreamController<QuerySnapshot>.broadcast();
  String _idUsuarioLogado;

  _recuperarDadosUsuarios() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    _idUsuarioLogado = usuarioLogado.uid;
  }

  Future<Stream<QuerySnapshot>> _adicionarListenerAnuncios() async {
    await _recuperarDadosUsuarios();

    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("meeus_anuncios")
        .document(_idUsuarioLogado)
        .collection("anuncios")
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  _removerAnuncio(String idAnuncio) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("meeus_anuncios")
        .doc(_idUsuarioLogado)
        .collection("anuncios")
        .doc(idAnuncio)
        .delete().then((_) {
      db.collection("anuncios")
          .doc(idAnuncio)
          .delete();
    });
  }

  @override
  void initState() {
    _adicionarListenerAnuncios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var carregandoDados = Center(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Carregando Dados"),
          CircularProgressIndicator()
        ],
      ),
    );
    return Scaffold(
        appBar: AppBar(
            title: Text("Meus Anúncios"),
            centerTitle: true,
            backgroundColor: Colors.indigo
        ),
        drawer: MenuLateral(),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/novo-anuncio");
          },
        ),
        body: StreamBuilder(
          stream: _controller.stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:

              case ConnectionState.waiting:
                return carregandoDados;
                break;

              case ConnectionState.active:

              case ConnectionState.done:
                if (snapshot.hasError)
                  return Text("Erro ao carregar dados.");

                QuerySnapshot querySnapshot = snapshot.data;

                return ListView.builder(
                    itemCount: querySnapshot.documents.length,
                    itemBuilder: (_, indice) {
                      List<DocumentSnapshot> anuncios = querySnapshot.documents
                          .toList();
                      DocumentSnapshot documentSnapshot = anuncios[indice];
                      Anuncio anuncio = Anuncio.fromDocumentSnapshot(
                          documentSnapshot);

                      return ItemAnuncio(
                        anuncio: anuncio,
                        onPressAlterar: (){
                          Navigator.pushNamed(context, "/editar-anuncio",
                          arguments: anuncio);
                        }
                        ,
                        onPressRemover: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Confirmar"),
                                  content: Text(
                                      "Deseja realmente excluir o anúncio ?"),
                                  actions: <Widget>[

                                    FlatButton(
                                      child: Text("Cancelar",
                                          style: TextStyle(color: Colors.green
                                          )
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("Remover",
                                          style: TextStyle(color: Colors.red
                                          )
                                      ),
                                      onPressed: () {
                                        _removerAnuncio(anuncio.id);
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              }
                          );
                        },
                      );
                    }
                );
            }
            return Column();
          },
        )
    );
  }
}
