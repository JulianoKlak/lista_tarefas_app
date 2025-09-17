import 'dart:convert';

class Tarefa {

  // atributos
  String nome;
  DateTime data;
  bool concluida;
  bool naoConcluida;

  // construtor
  Tarefa({required this.nome})
      : data = DateTime.now(),
        concluida = false,
        naoConcluida = false;

  // serialização simples para persistência
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'data': data.toIso8601String(),
      'concluida': concluida,
      'naoConcluida': naoConcluida,
    };
  }

  static Tarefa fromJson(Map<String, dynamic> map) {
    final t = Tarefa(nome: map['nome'] ?? '');
    try {
      t.data = DateTime.parse(map['data']);
    } catch (_) {
      t.data = DateTime.now();
    }
    t.concluida = map['concluida'] == true;
    t.naoConcluida = map['naoConcluida'] == true;
    return t;
  }

  // Helpers to encode/decode lists
  static String encodeList(List<Tarefa> tarefas) => jsonEncode(tarefas.map((t) => t.toJson()).toList());

  static List<Tarefa> decodeList(String jsonStr) {
    try {
      final ls = jsonDecode(jsonStr) as List<dynamic>;
      return ls.map((e) => Tarefa.fromJson(Map<String, dynamic>.from(e))).toList();
    } catch (_) {
      return [];
    }
  }
}