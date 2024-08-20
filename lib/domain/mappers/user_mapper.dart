import 'dart:convert';

import '../entity/user.dart';

abstract class UserMapper {
  static User clone(User instance) => User(
        id: instance.id,
        usuario: instance.usuario,
        nome: instance.nome,
        email: instance.email,
        telefone: instance.telefone,
        senha: instance.senha,
      );

  static Map<String, dynamic> fromEntitytoMap(User instance) {
    return {
      'id': instance.id,
      'usuario': instance.usuario,
      'nome': instance.nome,
      'email': instance.email,
      'telefone': instance.telefone,
      'senha': instance.senha
    };
  }

  static User fromMapToEntity(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      usuario: map['usuario'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      senha: map['senha'],
    );
  }

  static User fromJsonToEntity(String source) =>
      fromMapToEntity(json.decode(source));

  static String fromEntityToJson(User instance) =>
      json.encode(fromEntitytoMap(instance));
}
