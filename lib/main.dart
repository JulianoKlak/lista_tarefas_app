import 'package:flutter/material.dart';
import 'tarefa.dart';


void main() {
  runApp(new ListaTarefasApp());
}


class ListaTarefasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { //widget principal - material app
    return new MaterialApp(
      home: new ListaScreen(),
    ); //MaterialApp
  }
}



class ListaScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ListaScreenState();
  }
}

class ListaScreenState extends State<ListaScreen> {

  List<Tarefa> tarefas = [];

  void adicionaTarefa(String nome) {
    setState(() {
    tarefas.add(Tarefa(nome: nome));
  });
}

  Widget getItem(Tarefa tarefa) {

    return new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: new Icon(Icons.check_box, size: 42.0, color: Colors.green,),
                  padding: EdgeInsets.only(left: 10.0, right: 30.0),
                  onPressed: () { },
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(tarefa.nome, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                      Text(tarefa.data.toIso8601String()) //Intl
                    ],
                  )
              ],
            );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Lista de Tarefas"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) {
                  adicionaTarefa(value);
                },
              ),
            ),
              Expanded(
                child: ListView.builder(
                  itemCount: tarefas.length,
                  itemBuilder: (_, indice) {
                    return getItem(tarefas[indice]);
                  }
                )
                )
          ],
        ), //Column
      ); //Scaffold
  }
}