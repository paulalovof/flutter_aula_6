import '../../core/errors/errors_classes.dart';
import '../../domain/entity/user.dart';
import '../../helper/user_fake_repository.dart';
import '../../presentarion/state/user_list_state.dart';
import '../../presentarion/state/user_state.dart';
import 'user_api_contract.dart';

class UserServiceFakeApiImpl implements IUserApiService {
  UserFakApiDataBase api;

  UserServiceFakeApiImpl(this.api);

  @override
  Future<UserListState> fetchByUser(String name) async {
    try {
      var result = await api.getByName(name);
      return SuccessStateList(result);
    } on DefaultError catch (e) {
      return ErrorStateList(e);
    } catch (e) {
      return ErrorStateList(e);
    }
  }

  @override
  Future<UserListState> fetchAllUser() async {
    try {
      var result = await api.getAllUser();
      return SuccessStateList(result);
    } on DefaultError catch (e) {
      return ErrorStateList(e);
    } catch (e) {
      return ErrorStateList(e);
    }
  }

  @override
  Future<UserState> fetchByIdUser(int idUser) async {
    try {
      var result = await api.getUserById(idUser);
      return SuccessState(result);
    } on InvalidSearchText catch (e) {
      return ErrorState(e);
    } on DatasourceResultEmpty catch (e) {
      return ErrorState(e);
    } catch (e) {
      return ErrorState(e);
    }
  }

  @override
  Future<UserState> updateUser(User user) async {
    try {
      var result = await api.updateUser(user);
      return SuccessState(result);
    } on UserNotFound catch (e) {
      return ErrorState(e);
    } on DefaultError catch (e) {
      return ErrorState(e);
    } catch (e) {
      return ErrorState(e);
    }
  }
}
