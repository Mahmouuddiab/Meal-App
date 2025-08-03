class Failure{
  final String message;
  Failure([this.message="an expected error"]);
}
class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}
