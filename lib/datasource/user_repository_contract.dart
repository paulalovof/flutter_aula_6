import '../domain/entity/user.dart';
import '../presentarion/state/user_list_state.dart';
import '../presentarion/state/user_state.dart';

abstract interface class IUserRepository {
  Future<UserState> updateUser(User user);
  Future<UserState> getByIdUser(int idUser);
  Future<UserListState> getByUser(String name);
  Future<UserListState> getAllUser();
}