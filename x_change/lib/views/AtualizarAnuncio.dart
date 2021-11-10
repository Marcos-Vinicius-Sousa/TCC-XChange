import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validadores/Validador.dart';
import 'package:x_change/model/Anuncio.dart';
import 'package:x_change/util/Config.dart';
import 'package:x_change/views/MenuLateral.dart';
import 'package:x_change/views/widgets/BotaoCustomizado.dart';
import 'package:x_change/views/widgets/Inputcustomizado.dart';

class AtualizarAnuncio extends StatefulWidget {

  Anuncio anuncio;
  AtualizarAnuncio(this.anuncio);



  @override
  _AtualizarAnuncioState createState() => _AtualizarAnuncioState();
}

class _AtualizarAnuncioState extends State<AtualizarAnuncio> {

  final _formKey = GlobalKey<FormState>();
  List<File> _listaImagens = List();
  List<DropdownMenuItem<String>> _listaItensCidades = List();
  List<DropdownMenuItem<String>> _listaItensCategorias = List();
  Anuncio _anuncio;
  BuildContext _dialogContext;


  _selecionarImagemGaleria() async {
    File imagemSelecionada = await ImagePicker.pickImage(
        source: ImageSource.gallery);

    if (imagemSelecionada != null) {
      setState(() {
        _listaImagens.add(imagemSelecionada);
      });
    }
  }

  _abriDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text("Salvando Anúncio...")
              ],
            ),
          );
        }
    );
  }

  _salvarAnuncio() async {
    _abriDialog(_dialogContext);

    //Upload das imagens no Storage
    await _uploadImagens();
    print("Lista imagens: ${_anuncio.fotos.toString()}");

    //Salvar anuncio no FireStore
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    String idUsuarioLogado = usuarioLogado.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("meeus_anuncios")
        .document(idUsuarioLogado)
        .collection("anuncios")
        .document(_anuncio.id)
        .setData(_anuncio.toMap()).then((_) {
      //salvando anuncio publico
      db.collection("anuncios")
          .doc(_anuncio.id)
          .set(_anuncio.toMap()).then((_) {
        //Navigator.pop(_dialogContext);
        Navigator.pushReplacementNamed(context, "/meus-anuncios");
      });
    });
  }

  Future _uploadImagens() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();

    for (var imagem in _listaImagens) {
      String nomeImagem = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      StorageReference arquivo = pastaRaiz
          .child("meus_anuncios")
          .child(_anuncio.id)
          .child(nomeImagem);

      StorageUploadTask uploadTask = arquivo.putFile(imagem);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      String url = await taskSnapshot.ref.getDownloadURL();
      _anuncio.fotos.add(url);
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
    _anuncio = widget.anuncio;
  }

  _carregarItensDropdown() {
    _listaItensCategorias = Config.getCategorias();
    _listaItensCidades = Config.getCidades();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Atualizando Anúncio"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      drawer: MenuLateral(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //area de imagens
                FormField<List>(
                  initialValue: _listaImagens,
                  validator: (imagens) {
                    if (imagens.length == 0) {
                      return "Necessário selecionar uma imagem.";
                    }
                    return null;
                  },
                  builder: (state) {
                    return Column(children: <Widget>[
                      Container(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _listaImagens.length + 1,
                            itemBuilder: (context, indice) {
                              if (indice == _listaImagens.length) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      _selecionarImagemGaleria();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[400],
                                      radius: 50,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.add_a_photo,
                                            size: 40,
                                            color: Colors.grey[100],
                                          ),
                                          Text(
                                            "Adicionar",
                                            style: TextStyle(
                                                color: Colors.grey[100]
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (_listaImagens.length > 0) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              Dialog(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize
                                                      .min,
                                                  children: <Widget>[
                                                    Image.file(
                                                        _listaImagens[indice]),
                                                    FlatButton(
                                                      child: Text("Excluir"),
                                                      textColor: Colors.red,
                                                      onPressed: () {
                                                        setState(() {
                                                          _listaImagens
                                                              .removeAt(indice);
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              )
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(
                                          _listaImagens[indice]),
                                      child: Container(
                                        color: Color.fromRGBO(
                                            255, 255, 255, 0.4),
                                        alignment: Alignment.center,
                                        child: Icon(
                                            Icons.delete, color: Colors.red),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            }),
                      ),
                      if(state.hasError)
                        Container(
                          child: Text("[${state.errorText}]",
                            style: TextStyle(
                                color: Colors.red, fontSize: 14
                            ),
                          ),

                        )
                    ],
                    );
                  },
                ),
                // Menus Dropdown
                Row(children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: DropdownButtonFormField(
                        hint: Text("Cidades",
                            style: TextStyle(color: Colors.blue)),
                        onSaved: (cidade) {
                          _anuncio.cidade = cidade;
                        },
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),
                        items: _listaItensCidades,
                        validator: (valor) {
                          return Validador().add(
                              Validar.OBRIGATORIO, msg: "Campo Obrigatório")
                              .valido(valor);
                        },
                        onChanged: (valor) {
                          print("valor drop: ${_anuncio.cidade}");
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: DropdownButtonFormField(
                        hint: Text("Categoria",
                            style: TextStyle(color: Colors.blue)),
                        onSaved: (categoria) {
                          _anuncio.categoria = categoria;
                        },
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),
                        items: _listaItensCategorias,
                        validator: (valor) {
                          return Validador().add(
                              Validar.OBRIGATORIO, msg: "Campo Obrigatório")
                              .valido(valor);
                        },
                        onChanged: (valor) {
                          print("valor drop: ${_anuncio.categoria}");
                        },
                      ),
                    ),
                  ),
                ],),
                //Caixas de Textos e Botoes
                Padding(
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                  child: Inputcustomizado(
                    hint: "Título",
                    onSaved: (titulo) {
                      _anuncio.titulo = titulo;
                    },
                    validator: (valor) {
                      return Validador().add(
                          Validar.OBRIGATORIO, msg: "Campo Obrigatório")
                          .valido(valor);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Inputcustomizado(
                    hint: "Preço",
                    onSaved: (preco) {
                      _anuncio.preco = preco;
                    },
                    type: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true)
                    ],
                    validator: (valor) {
                      return Validador().add(
                          Validar.OBRIGATORIO, msg: "Campo Obrigatório")
                          .valido(valor);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Inputcustomizado(
                    hint: "Telefone",
                    onSaved: (telefone) {
                      _anuncio.telefone = "${_anuncio.telefone}";
                    },
                    type: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    validator: (valor) {
                      return Validador().add(
                          Validar.OBRIGATORIO, msg: "Campo Obrigatório")
                          .valido(valor);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Inputcustomizado(
                    hint: "Descrição (300 caracteres)",
                    maxLines: null,
                    onSaved: (descricao) {
                      _anuncio.descricao = descricao;
                    },
                    validator: (valor) {
                      return Validador().add(Validar.OBRIGATORIO,
                          msg: "Campo Obrigatório")
                          .maxLength(500, msg: "Máximo de 300 caracteres")
                          .valido(valor);
                    },
                  ),
                ),
                BotaoCustomizado(
                    texto: "Atualizar Anúncio",
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        //salvar campos
                        _formKey.currentState.save();

                        //Configurando dialog context
                        _dialogContext = context;

                        //salvar Anuncio
                        _salvarAnuncio();
                      }
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
