
import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validadores/Validador.dart';
import 'package:x_change/views/MenuLateral.dart';
import 'package:x_change/views/widgets/BotaoCustomizado.dart';
import 'package:x_change/views/widgets/Inputcustomizado.dart';

class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {

  final _formKey = GlobalKey<FormState>();
  List<File> _listaImagens = List();
  List<DropdownMenuItem<String>> _listaItensCidades = List();
  List<DropdownMenuItem<String>> _listaItensCategorias = List();


  _selecionarImagemGaleria() async {

    File imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);

    if(imagemSelecionada != null){
      setState(() {
        _listaImagens.add(imagemSelecionada);
      });
    }
  }

  @override
  void initState() {

    super.initState();
    _carregarItensDropdown();
  }

  _carregarItensDropdown(){

    _listaItensCategorias.add(
        DropdownMenuItem(child: Text("Automóvel"), value: "auto",)
    );

    _listaItensCategorias.add(
        DropdownMenuItem(child: Text("Imóvel"), value: "imóvel",)
    );
    _listaItensCategorias.add(
        DropdownMenuItem(child: Text("Eletronicos"), value: "eletro",)
    );
    _listaItensCategorias.add(
        DropdownMenuItem(child: Text("Moda"), value: "moda",)
    );
    _listaItensCategorias.add(
        DropdownMenuItem(child: Text("Serviços"), value: "serviço",)
    );
    _listaItensCategorias.add(
        DropdownMenuItem(child: Text("Esportes"), value: "esportes",)
    );
    
    _listaItensCidades.add(
        DropdownMenuItem(child: Text("São Vicente"), value: "São Vicente",)
    );
    _listaItensCidades.add(
        DropdownMenuItem(child: Text("Santos"), value: "Santos",)
    );
    _listaItensCidades.add(
        DropdownMenuItem(child: Text("Guaruja"), value: "Guaruja",)
    );
    _listaItensCidades.add(
        DropdownMenuItem(child: Text("Praia Grande"), value: "Praia Grande",)
    );
    _listaItensCidades.add(
        DropdownMenuItem(child: Text("Cubatão"), value: "Cubatão",)
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Anúncio"),
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
                  validator: ( imagens ){
                    if(imagens.length == 0){
                      return "Necessário selecionar uma imagem.";
                    }
                    return null;
                  },
                  builder: (state){
                    return Column(children: <Widget>[
                      Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _listaImagens.length + 1,
                            itemBuilder: (context,indice){
                              if( indice == _listaImagens.length){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    onTap: (){
                                      _selecionarImagemGaleria();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[400],
                                      radius: 50,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                              if(_listaImagens.length > 0){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (context)=> Dialog(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                              Image.file(_listaImagens[indice]),
                                              FlatButton(
                                                child: Text("Excluir"),
                                                textColor: Colors.red,
                                                onPressed: (){
                                                  setState(() {
                                                    _listaImagens.removeAt(indice);
                                                    Navigator.of(context).pop();
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
                                      backgroundImage: FileImage( _listaImagens[indice]),
                                      child: Container(
                                        color: Color.fromRGBO(255, 255, 255, 0.4),
                                        alignment: Alignment.center,
                                        child: Icon(Icons.delete, color: Colors.red),
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
                        hint: Text("Cidades"),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        ),
                        items: _listaItensCidades,
                        validator: (valor){
                          return Validador().add(Validar.OBRIGATORIO,msg: "Campo Obrigatório")
                              .valido(valor);
                        },
                        onChanged: (valor){
                          print("valor drop: ${valor}");
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: DropdownButtonFormField(
                        hint: Text("Categoria"),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),
                        items: _listaItensCategorias,
                        validator: (valor){
                          return Validador().add(Validar.OBRIGATORIO,msg: "Campo Obrigatório")
                              .valido(valor);
                        },
                        onChanged: (valor){
                          print("valor drop: ${valor}");
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
                    validator: (valor){
                      return Validador().add(Validar.OBRIGATORIO,msg: "Campo Obrigatório")
                          .valido(valor);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Inputcustomizado(
                    hint: "Preço",
                    type: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true)
                    ],
                    validator: (valor){
                      return Validador().add(Validar.OBRIGATORIO,msg: "Campo Obrigatório")
                          .valido(valor);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Inputcustomizado(
                    hint: "Telefone",
                    type: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    validator: (valor){
                      return Validador().add(Validar.OBRIGATORIO,msg: "Campo Obrigatório")
                          .valido(valor);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Inputcustomizado(
                    hint: "Descrição (300 caracteres)",
                    maxLines: null,
                    validator: (valor){
                      return Validador().add(Validar.OBRIGATORIO,msg: "Campo Obrigatório")
                      .maxLength(500,msg: "Máximo de 300 caracteres")
                          .valido(valor);
                    },
                  ),
                ),
                BotaoCustomizado(
                  texto: "Cadastrar Anúncio",
                  onPressed: (){
                    if(_formKey.currentState.validate()){

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
