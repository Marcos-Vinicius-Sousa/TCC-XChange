import 'package:flutter/material.dart';
import 'package:x_change/views/MenuLateral.dart';

class Sobre extends StatefulWidget {
  @override
  _SobreState createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Sobre"),
            centerTitle: true,
            backgroundColor: Colors.indigo),
        drawer: MenuLateral(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(130,30,100,20),
                      child: Text(
                        "XChange",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                      "Xchange é uma aplicação voltada para a troca de serviços e produtos. Baseada em maneiras de clientes ofertarem e buscarem produtos que querem, ou serviços que precisam ser feitos. O intuito do Xchange é focar inteiramente em trocas, sem que seu usuário precise ter qualquer tipo de gasto quando utilizar algo encontrado aqui. Este serviço pode trazer maneiras econômicas para alguém ter o que precisa e também ajudar outra pessoa que busca algo que ela pode oferecer",
                      style: TextStyle(
                        fontSize: 25
                      ),),
                ) 
              ],
            ),
          ),
        ));
  }
}
