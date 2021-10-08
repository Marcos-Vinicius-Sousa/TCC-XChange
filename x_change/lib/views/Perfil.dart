import 'dart:html';

import 'package:flutter/material.dart';
import 'package:validadores/Validador.dart';
import 'package:x_change/views/MenuLateral.dart';
import 'package:image_picker/image_picker.dart';
import 'package:x_change/views/widgets/Inputcustomizado.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  final _formKey = GlobalKey<FormState>();
  File imagem;

  //Controladores

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerConfirmacaoSenha = TextEditingController();
  String _mensagemErro = "";

  _selecionarImagemGaleria() async {
    File imagemSelecionada = (await ImagePicker.pickImage(
        source: ImageSource.gallery)) as File;

    if (imagemSelecionada != null) {
      setState(() {
        imagem = imagemSelecionada;
      });
    }
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
          decoration: BoxDecoration(color: Colors.grey),
          padding: EdgeInsets.all(16),
          child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                Stack(

                children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(130, 20, 130, 20),
                  child:CircleAvatar(
                    radius: 50,
                    child: ClipOval(child: Image.asset('imagem/usuario.png', height: 300, width: 300, fit: BoxFit.cover,),),
                  )),
                Padding(padding: EdgeInsets.fromLTRB(200, 100, 100, 20),
                    child:Positioned(bottom: 1, right: 1 ,child: Container(
                      height: 40, width: 40,
                      child: Icon(Icons.add_a_photo, color: Colors.white,),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                    ))
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
                      child: TextField(
                        obscureText: true,
                        controller: _controllerSenha,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(50, 16, 50, 16),
                            hintText: "Senha",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: TextField(
                        obscureText: true,
                        controller: _controllerSenha,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(50, 16, 50, 16),
                            hintText: "Senha",
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
                          "Cadastrar",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.deepOrange,
                        padding: EdgeInsets.fromLTRB(50, 16, 50, 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {

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
