import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'views/Anuncios.dart';
import 'model/Usuario.dart';

class Cadastro extends StatefulWidget {

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  //Controladores

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerConfirmacaoSenha = TextEditingController();
  String _mensagemErro = "";


  _validarCampos() {
    // Recuperando dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    String confirmasenha = _controllerConfirmacaoSenha.text;

    if (/*nome.isNotEmpty && */ nome.length > 3) {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty && senha.length > 6 && senha == confirmasenha) {
          setState(() {
            _mensagemErro = "";
          });

          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;


          _cadastrarUsuario(usuario);
        } else {
          setState(() {
            _mensagemErro = "Senha deve ter mais do que 6 caracteres e deve ser igual a confirmação de senha";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha o e-mail utilizando  @";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Nome precisa ter mais do que 3 caracteres.";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser) {
      // Salvando dados do usuario
      FirebaseFirestore db = FirebaseFirestore.instance;
      db.collection("usuarios")
          .doc(firebaseUser.user.uid)
          .set(usuario.toMap());

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Anuncios()
          )
      );
    }).catchError((error) {
      setState(() {
        print("erro app: " + error.toString());
        _mensagemErro =
        "Erro ao cadastrar usuário, verifique os campos e tente novamente.";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(
          title: Text("Cadastro"),
          backgroundColor: Colors.indigo
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.indigo),
        padding: EdgeInsets.all(16),
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Image.asset(
                        "imagem/usuario.png", width: 100, height: 100),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5,8,10,10),
                    child: TextField(
                      controller: _controllerNome,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "Nome",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5,8,10,10),
                    child: TextField(
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "E-mail",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5,8,10,10),
                    child: TextField(
                      obscureText: true,
                      controller: _controllerSenha,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "Senha",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(5,8,10,10),
                      child: TextField(
                        obscureText: true,
                        controller: _controllerConfirmacaoSenha,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Confirme a Senha",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      )
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(5,8,10,10),
                    child: RaisedButton(
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.deepOrange,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        _validarCampos();
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
