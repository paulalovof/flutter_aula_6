import '../../datasource/user_repository_contract.dart';
import '../../presentarion/state/user_list_state.dart';
import 'use_case_contract.dart';

// class GetAllPetsUseCaseImpl implements IUseCaseNoParams<PetListState> {
class GetAllPetsUseCaseImpl implements IUseCase<UserListState, NoParams> {
  final IUserRepository _repository;

  GetAllPetsUseCaseImpl({
    required IUserRepository repository,
  }) : _repository = repository;

  @override
 Future<UserListState> call(NoParams noParams) {
  // Future<PetListState> call() {
    return _repository.getAllUser();
  }
}
