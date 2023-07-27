import 'global_ws_model.dart';

class Tree extends GlobalWSModel {
  final String? codigo;
  final String? nome;
  final String? especie;
  final int? dapt;
  final int? h_m;
  final int? dc_m;
  final String? local;
  final String? efs;
  final String? conflito1;
  final int? esq;
  final int? pos;
  final int? pass;
  final String? manejo;
  final String? bairro;
  final dynamic latitude;
  final dynamic longitude;

  Tree({
    required this.codigo,
    required this.nome,
    required this.especie,
    required this.dapt,
    required this.h_m,
    required this.dc_m,
    required this.local,
    required this.efs,
    required this.conflito1,
    required this.esq,
    required this.pos,
    required this.pass,
    required this.manejo,
    required this.bairro,
    required this.latitude,
    required this.longitude,
    required super.status,
    required super.msg,
    required super.id,
    required super.rows,
  });

  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
      latitude: json['latitude'],
      longitude: json['longitude'],
      status: json['status'],
      msg: json['msg'],
      id: json['id'],
      rows: json['rows'],
      codigo: json['codigo'] ?? "",
      nome: json['nome'] ?? "",
      especie: json['especie'] ?? "",
      dapt: json['dapt'] ?? 0,
      h_m: json['h_m'] ?? 0,
      dc_m: json['dc_m'] ?? 0,
      local: json['local'] ?? "",
      efs: json['efs'] ?? "",
      conflito1: json['conflito1'] ?? "",
      esq: json['esq'] ?? 0,
      pos: json['pos'] ?? 0,
      pass: json['pass'] ?? 0,
      manejo: json['manejo'] ?? "",
      bairro: json['bairro'] ?? "",
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
      'id': id,
      'rows': rows,
    };
  }
}
