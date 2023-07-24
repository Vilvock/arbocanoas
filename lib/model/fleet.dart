
import 'global_ws_model.dart';

class Fleet extends GlobalWSModel{
  final String url;
  final String nome;
  final String obs;
  final String data_cadastro;
  final int ordem;

  Fleet({
    required this.url,
    required this.nome,
    required this.obs,
    required this.data_cadastro,
    required this.ordem,  required super.status, required super.msg, required super.id, required super.rows,
  });

  factory Fleet.fromJson(Map<String, dynamic> json) {
    return Fleet(
      url: json['url'],
      nome: json['nome'],
      obs: json['obs'],
      data_cadastro: json['data_cadastro'],
      ordem: json['ordem'],
      status: json['status'],
      msg: json['msg'],
      id: json['id'],
      rows: json['rows'],
    );
  }

}