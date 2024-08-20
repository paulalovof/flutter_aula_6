import '../domain/entity/user.dart';
import '../external/services/user_api_contract.dart';
import '../presentarion/state/user_list_state.dart';
import '../presentarion/state/user_state.dart';
import 'user_repository_contract.dart';

class UserRepositoryImpl implements IUserRepository {
  IUserApiService serviceApi;
  UserRepositoryImpl(this.serviceApi);

  @override
  Future<UserListState> getByUser(String name) async {
    await Future.delayed(const Duration(seconds: 2));
    return serviceApi.fetchByUser(name);
  }

  @override
  Future<UserListState> getAllUser() async {
    await Future.delayed(const Duration(seconds: 2));
    return serviceApi.fetchAllUser();
  }

  @override
  Future<UserState> getByIdUser(int idUser) async {
    await Future.delayed(const Duration(seconds: 2));
    return serviceApi.fetchByIdUser(idUser);
  }

  @override
  Future<UserState> updateUser(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    return serviceApi.updateUser(user);
  }
}
