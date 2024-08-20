sealed class UserState {
  const UserState();
}
class InitialState extends UserState {}

final class SuccessState<User> implements UserState {
  const SuccessState(this.value);
  final User value;
}

final class ErrorState<Failure> implements UserState {
  const ErrorState(this.failure);
  final Failure failure;
}