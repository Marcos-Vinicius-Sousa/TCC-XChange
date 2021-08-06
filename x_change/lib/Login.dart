import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:x_change/views/widgets/BotaoCustomizado.dart';
import 'package:x_change/views/widgets/InputcustomizadoSenha.dart';
import 'Cadastro.dart';
import 'views/Anuncios.dart';
import 'model/Usuario.dart';
import 'views/widgets/Inputcustomizado.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    // Recuperando dados dos campos

    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty) {
        setState(() {
          _mensagemErro = "";
        });
        Usuario usuario = Usuario();
        usuario.email = email.replaceAll(" ", "");
        usuario.senha = senha.replaceAll(" ", "");
        _logarUsuario(usuario);
      } else {
        setState(() {
          _mensagemErro = "Preencha a senha.";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o e-mail utilizando  @";
      });
    }
  }

  _logarUsuario(Usuario usuario) {
    Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser) {
      //Navigator.pushReplacementNamed(context,"/");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Anuncios()
          )
      );
    }).catchError((error) {
      setState(() {
        _mensagemErro =
        "Erro ao identificar usuário, verifique e-mail e senha e tente novamente.";
      });
    });
  }

  Future _verificarUsuarioLogado() async {
    Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
    auth.signOut();
    // recuperando o usuario que esta logado no momento
    Auth.User usuarioLogado = await auth.currentUser;
    if (usuarioLogado != null) {
      Navigator.pushReplacementNamed(context, "/");
    }
  }

  @override
  void initState() {
    _verificarUsuarioLogado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
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
                        "imagem/ativo5.png", width: 100, height: 100
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Inputcustomizado(
                      controller: _controllerEmail,
                      hint: "E-mail",
                      autofocus: true,
                      type: TextInputType.emailAddress,
                    ),

                  ),
                  InputcustomizadoSenha(
                    controller: _controllerSenha,
                    hint: "Senha",
                    obscure: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: BotaoCustomizado(
                      texto: "Entrar",
                      onPressed: () {
                        _validarCampos();
                      },

                    ),
                  ),

                  /*Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.deepOrange,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)
                      ),
                      onPressed: (){

                        _validarCampos();
                      },
                    ),
                  ),*/
                  Center(
                    child: GestureDetector(
                      child: Text(
                        "Não tem conta? Cadastre-se!",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cadastro()
                            )
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Center(
                        child: Text(
                            _mensagemErro,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                            )
                        )
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
