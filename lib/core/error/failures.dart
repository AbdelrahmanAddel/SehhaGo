abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class OfflineFailure extends Failure {
  const OfflineFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network Failure']);
}
