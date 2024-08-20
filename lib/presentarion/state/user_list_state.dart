sealed class UserListState {
  const UserListState();
}
class InitialStateList extends UserListState {}

final class SuccessStateList<User> implements UserListState {
  const SuccessStateList(this.value);
  final List<User> value;
}

final class ErrorStateList<Failure> implements UserListState {
  const ErrorStateList(this.failure);
  final Failure failure;
}