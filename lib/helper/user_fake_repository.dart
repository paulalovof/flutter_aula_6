import 'dart:math';

import '../core/errors/errors_classes.dart';
import '../core/errors/errors_messagens.dart';
import '../domain/entity/user.dart';
import '../domain/mappers/user_mapper.dart';
import 'user_fake_factory.dart';

class UserFakApiDataBase {
  late List<User> users;

  UserFakApiDataBase({int numInstance = 10}) {
    users = List.generate(
      numInstance,
      (int index) => UserFakeFactory.factory(index + 1),
    );
  }

  Future<List<User>> getAllUser() async {
    final filter = null;

    if (Random().nextBool()) {
      return throw APIFailure('meu erro');
    }

    final users = _filter(filter: filter);

    return users == null || users.isEmpty
        ? throw DatasourceResultEmpty()
        : users.map((e) => UserMapper.clone(e)).toList();
  }

  Future<void> updateUser(User user) async {
    try {
      int index = users.indexWhere((userItem) => userItem.id == user.id);

      if (index != -1) {
        users[index] = user.copyWith();
      }
      throw UserNotFound(MessagesError.userNotFoundError);
    } catch (e) {
      throw DefaultError(e.toString());
    }
  }

  Future<User> getUserRanbom() async {
    return users.isEmpty
        ? throw DatasourceResultEmpty()
        : UserMapper.clone(
            users[Random().nextInt(users.length)],
          );
  }

  Future<List<User>> getByName(String name) async {
    final filter = name.trim().isNotEmpty
        ? (User u) => u.nome.toLowerCase().contains(name.toLowerCase().trim())
        : throw InvalidSearchText();

    final instances = _filter(filter: filter);

    return instances.isEmpty
        ? throw DatasourceResultEmpty()
        : instances.map((e) => UserMapper.clone(e)).toList();
  }

  Future<User> getUserById(int idUser) async {
    final filter = (idUser > 0)
        ? (User u) => u.id == idUser
        : throw InvalidSearchText(MessagesError.idError);
    final instances = _filterUser(filter: filter);

    if (instances == null) {
      throw DatasourceResultEmpty(MessagesError.userNotFoundError);
    }

    return instances;
  }

  List<User> _filter({bool Function(User)? filter}) {
    final users = filter == null ? this.users : this.users.where(filter).toList();

    return users;
  }

  User? _filterUser({required bool Function(User) filter}) {
    try {
      return users.firstWhere(filter);
    } catch (e) {
      return null;
    }
  }
}
