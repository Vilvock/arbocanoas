import 'global_ws_model.dart';

class User extends GlobalWSModel {
  final String descricao;
  final String data;
  final String titulo;

  User({
    required this.descricao,
    required this.data,
    required this.titulo,
    required super.status,
    required super.msg,
    required super.id,
    required super.rows,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      descricao: json['descricao'],
      data: json['data'],
      titulo: json['titulo'],
      status: json['status'],
      msg: json['msg'],
      id: json['id'],
      rows: json['rows'],
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
