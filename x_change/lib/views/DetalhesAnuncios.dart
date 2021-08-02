import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
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
            )
          ],)
        ],
      ),
    );
  }
}
