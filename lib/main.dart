import 'package:flutter/material.dart';
import 'tarefa.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  TextEditingController controller = new TextEditingController();
  static const String _storageKey = 'tarefas';

  void adicionaTarefa(String nome) {
    setState(() {
      tarefas.add(Tarefa(nome: nome));
      _salvaTarefas();
  });

  controller.clear();
}

  Widget getItem(Tarefa tarefa) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            tarefa.concluida ? Icons.check_box : Icons.check_box_outline_blank,
            size: 42.0,
            color: Colors.green,
          ),
          padding: EdgeInsets.only(left: 10.0, right: 8.0),
                  onPressed: () {
                    setState(() {
                      tarefa.concluida = true;
                      _salvaTarefas();
                    });
                  },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                tarefa.nome,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Text(tarefa.data.toIso8601String()) //Intl
            ],
          ),
        ),
        // Delete button
        IconButton(
          icon: Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () async {
            // Show confirmation dialog before removing
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Confirmar'),
                content: Text('Deseja apagar a tarefa "${tarefa.nome}"?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: Text('Apagar', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );

            if (confirm == true) {
              setState(() {
                tarefas.remove(tarefa);
                _salvaTarefas();
              });
            }
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _carregaTarefas();
  }

  Future<void> _carregaTarefas() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = prefs.getString(_storageKey);
      if (jsonStr != null && jsonStr.isNotEmpty) {
        setState(() {
          tarefas = Tarefa.decodeList(jsonStr);
        });
      }
    } catch (e) {
      // ignore load errors
    }
  }

  Future<void> _salvaTarefas() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKey, Tarefa.encodeList(tarefas));
    } catch (e) {
      // ignore save errors
    }
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
                controller: controller,
                onSubmitted: (value) { // poderia fazer somente com  onSubmitted: adicionaTarefa,
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