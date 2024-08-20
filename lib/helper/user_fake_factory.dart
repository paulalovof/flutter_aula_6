import 'dart:math';

//import 'package:asp_teste/domain/entity/user.dart';
import 'package:faker_dart/faker_dart.dart';
import '../domain/entity/user.dart';


abstract class UserFakeFactory {
  static User factory(int? id) {
    final faker = Faker.instance;
    faker.setLocale(FakerLocaleType.pt_PT);

    var instance = User(
      id: id ?? faker.datatype.number(min: 1),
      usuario: faker.name.firstName(),
      nome: faker.name.fullName(),
      email: faker.internet.email(),
      telefone: faker.phoneNumber.phoneNumber(),
      senha: 'password'
    );
    return instance;
  }
}
