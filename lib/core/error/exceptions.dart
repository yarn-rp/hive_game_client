//This file contains exceptions. Add Exceptions in here.
//Some basic exceptions example were provided.

class UnexpectedException implements Exception {
  const UnexpectedException();
}

class ParsingException implements Exception {
  const ParsingException();
}

class ServerException implements Exception {
  const ServerException();
}

class AuthenticationException implements Exception {
  const AuthenticationException();
}

class CacheException implements Exception {
  const CacheException();
}

class MaxRetryAttemptsReachedException implements Exception {
  const MaxRetryAttemptsReachedException();
}

class ClientException implements Exception {
  const ClientException();
}
