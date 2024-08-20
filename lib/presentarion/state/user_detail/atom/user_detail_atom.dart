//import 'package:asp/asp.dart';

import 'package:atom/atom.dart';
import 'package:flutter_aula_5/domain/entity/user.dart';
import 'package:flutter_aula_5/presentarion/state/user_state.dart';


abstract class UserDetailStore {
// atom
  static final userEditingAtom = Atom<bool>(false);
  static final userLoadingAtom = Atom<bool>(false);
  static final usertUpdatedAtom = Atom<UserState>(InitialState());
  static final userByIdAtom = Atom<UserState>(InitialState());

// actions
  static final toggleUserEditingAction = Atom<bool?>(null);
  static final updateUser = Atom<User?>(null);
  static final fetchUserById = Atom<int>(0);
}
