class Tarefa {

    // atributos
    String nome;
    DateTime data;
    bool concluida;

    //construtor
    Tarefa({required this.nome})
      : data = DateTime.now(),
        concluida = false;
}


// Tarefa t = new Tarefa("Estudar Dart");