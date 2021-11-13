import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:x_change/views/MenuLateral.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Anuncios.dart';


class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  final _formKey = GlobalKey<FormState>();
  //File imagem = Image.asset('imagem/usuario.png',height: 300, width: 300, fit: BoxFit.cover) as File;

  //Controladores

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();


  String _mensagemErro = "";
  File _imagem;

  String _UrlRecuperada;
  String _usuarioLogado;
  bool _subindoImagem = false;



  Future _recuperarImagem(String origemImagem) async{

    File imagemSelecionada;

    switch(origemImagem){
      case "camera":
        imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case "galeria":
        imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
    }

    setState(() {
      _imagem = imagemSelecionada;
      if(_imagem != null){
        _subindoImagem = true;
        _uploadImagem();
      }
    });
  }

  Future _uploadImagem()async{
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz
    .child("perfil")
    .child(_usuarioLogado +".jpg");

    StorageUploadTask task =  arquivo.putFile(_imagem);
    
    task.events.listen((StorageTaskEvent storageTaskEvent) {
      if(storageTaskEvent.type == StorageTaskEventType.progress){
        setState(() {
          _subindoImagem = true;
        });
      }else if(storageTaskEvent.type == StorageTaskEventType.success){
        setState(() {
          _subindoImagem = false;
        });
      }
    });

    //Recuperando Url da Imagem
    task.onComplete.then((StorageTaskSnapshot snapshot)  {
      _recuperarUrlImagem(snapshot);
    });
  }

  Future _recuperarUrlImagem(StorageTaskSnapshot snapshot)async {

    String url = await snapshot.ref.getDownloadURL();
    _atualizarUrlImagem(url);
    setState(() {
      _UrlRecuperada = url;
    });
  }
  _atualizarUrlImagem(String url)async {

    Map<String, dynamic> dadosAtualizar = {
      "urlImagem": url
    };

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("usuarios")
        .doc(_usuarioLogado)
        .update(dadosAtualizar);

  }

  _atualizar()async {

    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    Map<String, dynamic> dadosAtualizar = {
      "nome": nome,
      "email": email,
    };

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("usuarios")
      .doc(_usuarioLogado)
      .update(dadosAtualizar);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Anuncios()
        )
    );
  }

  _recuperarUsuario()async{

    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    _usuarioLogado = usuarioLogado.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await db.collection("usuarios")
      .doc(_usuarioLogado)
      .get();

    Map<String, dynamic> dados = snapshot.data();
    _controllerNome.text = dados["nome"];
    _controllerEmail.text = dados["email"];

    if(dados["urlImagem"] != null){
      setState(() {
        _UrlRecuperada = dados["urlImagem"];
      });

    }

  }

  @override
  void initState() {
    super.initState();
    _recuperarUsuario();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Perfil"),
            centerTitle: true,
            backgroundColor: Colors.indigo
        ),
        drawer: MenuLateral(),
        body: Container(
          decoration: BoxDecoration(color: Colors.white70),
          padding: EdgeInsets.all(16),
          child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                  //carregando
                     _subindoImagem
                          ? CircularProgressIndicator()
                          : Container(),
                    CircleAvatar(
                      radius: 100,
                      backgroundImage:
                      _UrlRecuperada != null
                      ?NetworkImage(_UrlRecuperada)
                      : null,
                      backgroundColor: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: RaisedButton(
                            color: Colors.indigo,
                              onPressed: (){
                                _recuperarImagem("camera");
                              },
                              child: Text("Câmera",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        Padding(padding: EdgeInsets.all(10),
                            child:RaisedButton(
                              color: Colors.indigo,
                              onPressed: (){
                                _recuperarImagem("galeria");
                              },
                              child: Text("Galeria",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white
                                ),),

                            ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: TextField(
                        controller: _controllerNome,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(50, 16, 50, 16),
                            hintText: "Nome",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: TextField(
                        controller: _controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(50, 16, 50, 16),
                            hintText: "E-mail",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: RaisedButton(
                        child: Text(
                          "Salvar",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.deepOrange,
                        padding: EdgeInsets.fromLTRB(50, 16, 50, 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          _atualizar();
                        },
                      ),
                    ),
                    Center(
                        child: Text(
                            _mensagemErro,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                            )
                        )
                    )
                  ],
                ),
              )),
        ),
    );
  }
}
