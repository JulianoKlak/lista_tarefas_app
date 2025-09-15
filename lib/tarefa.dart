class Tarefa {

    // atributos
    String nome;
    DateTime data;
    bool concluida;

    //construtor
    Tarefa(String nome){
        this.nome = nome;
        this.data = DateTime.now();
        this.concluida = false;
    };
}


// Tarefa t = new Tarefa("Estudar Dart");