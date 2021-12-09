import 'package:equatable/equatable.dart';

const String _kUnexpectedError = 'Ups. Something unexpected happended.';

abstract class Failure with EquatableMixin {
  const Failure({this.properties});

  final List? properties;

  @override
  String toString() => _kUnexpectedError;
  @override
  List<Object?> get props => [properties];
}

class ServerFailure extends Failure {
  const ServerFailure({this.message = 'Server Failure'});
  final String message;

  @override
  String toString() => message;
}

class ParsingFailure extends Failure {
  const ParsingFailure({this.message = 'Parsing Failure'});
  final String message;

  @override
  String toString() => message;
}

class NoInternetConnectionFailure extends Failure {
  const NoInternetConnectionFailure({
    this.message =
        'Seems like you do not have internet connection. Check and try again.',
  });

  final String message;

  @override
  String toString() => message;
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({this.message = 'Authentication Failure'});

  final String message;

  @override
  String toString() => message;
}

class InvalidCredentialsFailure extends Failure {
  InvalidCredentialsFailure({this.message = 'Invalid Credentials Failure'});

  final String message;

  @override
  String toString() => message;
}

class EmailAlreadyTakenFailure extends Failure {
  EmailAlreadyTakenFailure({this.message = 'Email already taken Failure'});

  final String message;

  @override
  String toString() => message;
}

class EmailNotRegisteredFailure extends Failure {
  EmailNotRegisteredFailure({this.message = 'Email not registered Failure'});

  final String message;

  @override
  String toString() => message;
}

class CacheFailure extends Failure {
  const CacheFailure({this.message});

  final String? message;

  @override
  String toString() => message ?? 'Cache Failure';
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({this.message});

  final String? message;

  @override
  String toString() => message ?? 'Unexpected Failure';
}
