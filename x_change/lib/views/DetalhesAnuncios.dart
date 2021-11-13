import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:x_change/model/Anuncio.dart';

class DetalhesAnuncios extends StatefulWidget {

  Anuncio anuncio;
  DetalhesAnuncios(this.anuncio);


  @override
  _DetalhesAnunciosState createState() => _DetalhesAnunciosState();
}

class _DetalhesAnunciosState extends State<DetalhesAnuncios> {

  Anuncio _anuncio;


  List<Widget> _getListaImagens(){
    List<String> listaUrlImagens = _anuncio.fotos;
    return listaUrlImagens.map((url){
      return Container(
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
              fit: BoxFit.fitWidth
            )
          ),
        );
    }).toList();
  }

  _ligarTelefone(String telefone) async {

    if(await canLaunch("tel: $telefone")){
      await launch("tel: $telefone");
    }else{
      print("Não pode fazer essa ligação");
    }
  }

  @override
  void initState() {
    super.initState();
    _anuncio = widget.anuncio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Anúncio"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Stack(
        children:<Widget>[

          ListView(children: <Widget>[
            SizedBox(
              height: 250,
              child: Carousel(
                images: _getListaImagens(),
                dotSize: 8,
                dotBgColor: Colors.transparent,
                dotColor: Colors.white,
                autoplay: false,
                dotIncreasedColor: Colors.indigo,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      "R\$ ${_anuncio.preco}",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo
                    ),
                  ),
                  Text(
                    "${_anuncio.titulo}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(),
                  ),
                  Text(
                    "Descrição",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${_anuncio.descricao}",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(),
                  ),
                  Text(
                    "Contato",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Text(
                      "${_anuncio.telefone}",
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                  )
                ],
              ),
            )
          ],),

          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: GestureDetector(
              child: Container(
                child: Text(
                    "Ligar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
              onTap: (){
                _ligarTelefone(_anuncio.telefone);
              },
            ),
          )

        ],
      ),
    );
  }
}
