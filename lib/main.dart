import 'package:flutter/material.dart';


void main() {
  runApp(new ListaTarefasApp());
}


class ListaTarefasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { //widget principal - material app
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Lista de Tarefas"),
        ),
        body: Column(), //Column
      ) //Scaffold
    ); //MaterialApp
  }
}