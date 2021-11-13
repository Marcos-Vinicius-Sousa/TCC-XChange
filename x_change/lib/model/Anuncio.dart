import 'package:cloud_firestore/cloud_firestore.dart';

class Anuncio {

  String _id;
  String _cidade;
  String _categoria;
  String _titulo;
  String _preco;
  String _telefone;
  String _descricao;
  List<String> _fotos;

  Anuncio();

  Anuncio.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.id;
    this.cidade = documentSnapshot["cidade"];
    this.categoria = documentSnapshot["categoria"];
    this.titulo = documentSnapshot["titulo"];
    this.preco = documentSnapshot["preco"];
    this.telefone = documentSnapshot["telefone"];
    this.descricao = documentSnapshot["descricao"];
    this.fotos = List<String>.from(documentSnapshot["fotos"]);
  }

  Anuncio.gerarId() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference anuncios = db.collection("meus_anuncios");
    this.id = anuncios.document().documentID;

    this.fotos = [];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "cidade": this.cidade,
      "categoria": this.categoria,
      "titulo": this.titulo,
      "preco": this.preco,
      "telefone": this.telefone,
      "descricao": this.descricao,
      "fotos": this.fotos
    };

    return map;
  }

  List<String> get fotos => _fotos;

  set fotos(List<String> value) {
    _fotos = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get preco => _preco;

  set preco(String value) {
    _preco = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}
