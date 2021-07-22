import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:x_change/Login.dart';
import 'package:x_change/views/Anuncios.dart';
import 'package:x_change/views/MeusAnuncios.dart';
import 'package:x_change/views/NovoAnuncio.dart';

class RouterGenerator{

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){
      case"/":
        return MaterialPageRoute(
          builder: (_) => Anuncios()
        );
        break;
      case"/login":
        return MaterialPageRoute(
            builder: (_) => Login()
        );
        break;
      case"/meus-anuncios":
        return MaterialPageRoute(
            builder: (_) => MeusAnuncios()
        );
        break;
      case"/novo-anuncio":
        return MaterialPageRoute(
            builder: (_) => NovoAnuncio()
        );
        break;
      default:
        _erroRota();

    }
  }

  static Route<dynamic> _erroRota(){

    return MaterialPageRoute(
      builder: (_){
        return Scaffold(
          appBar: AppBar(
            title: Text("Tela não encontrada!"),
          ),
          body: Center(
            child: Text("Tela não encontrada!"),
          ),
        );
      }
    );
  }
}