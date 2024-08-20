import 'errors_messagens.dart';

sealed class Failure implements Exception {
  final String msg;
  Failure(this.msg);
  
  @override
  String toString() => '$runtimeType: $msg!!!';
}

class DefaultError extends Failure {
  DefaultError([String msg = MessagesError.defaultError]) : super(msg);

  // @override
  // String toString() => 'DefaultError(msg: $msg)';
}

class UserNotFound extends Failure {
  UserNotFound([String msg = MessagesError.defaultError]) : super(msg);

  // @override
  // String toString() => 'DefaultError(msg: $msg)';
}

class InvalidSearchText extends Failure {
  InvalidSearchText([String msg = MessagesError.defaultError]) : super(msg);

  // @override
  // String toString() => 'Error1(msg: $msg)';
}

class EmptyList extends Failure {
  EmptyList([String msg = MessagesError.defaultError]) : super(msg);

  // @override
  // String toString() => 'Error1(msg: $msg)';
}
class EmptyField extends Failure {
  EmptyField([String msg = MessagesError.defaultError]) : super(msg);

  // @override
  // String toString() => 'Error1(msg: $msg)';
}
class InvalidDate extends Failure {
  InvalidDate([String msg = MessagesError.defaultError]) : super(msg);

  // @override
  // String toString() => 'Error1(msg: $msg)';
}

class DatasourceResultEmpty extends Failure {
  DatasourceResultEmpty([String msg = MessagesError.defaultError]) : super(msg);

  //@override
  //String toString() => '$runtimeType: $msg!!!';
}

class APIFailure extends Failure {
  APIFailure([String msg = MessagesError.defaultError]) : super(msg);

  // @override
  // String toString() => 'Error1(msg: $msg)';
}
