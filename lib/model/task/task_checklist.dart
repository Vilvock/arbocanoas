
import '../global_ws_model.dart';

class TaskChecklist extends GlobalWSModel{
  final String url;
  final String nome;
  final int check;
  final int id_checklist;
  final dynamic perc_progresso;
  final String previsao;



  TaskChecklist({
    required this.url,
    required this.nome,
    required this.check,
    required this.id_checklist,
    required this.perc_progresso,
    required this.previsao, required super.status, required super.msg, required super.id, required super.rows,
  });

  factory TaskChecklist.fromJson(Map<String, dynamic> json) {
    return TaskChecklist(
      url: json['url'],
      nome: json['nome'],
      check: json['check'],
      id_checklist: json['id_checklist'],
      perc_progresso: json['perc_progresso'],
      previsao: json['previsao'],
      status: json['status'],
      msg: json['msg'],
      id: json['id'],
      rows: json['rows'],
    );
  }

}