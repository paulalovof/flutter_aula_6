import '../../domain/entity/user.dart';
import '../../presentarion/state/user_list_state.dart';
import '../../presentarion/state/user_state.dart';

abstract interface class IUserApiService {
  Future<UserState> updateUser(User user);
  Future<UserState> fetchByIdUser(int idUser);
  Future<UserListState> fetchByUser(String name);
  Future<UserListState> fetchAllUser();
}
