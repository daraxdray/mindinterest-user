abstract class Failure with Exception {
  Failure(this.message);

  final String message;
}

class ApiFailure extends Failure {
  ApiFailure(String message, {this.statusCode}) : super(message);
  int? statusCode;
}

class NetworkFailure extends Failure {
  NetworkFailure(String message, {this.statusCode}) : super(message);
  int? statusCode;
}

class FileUploadFailure extends Failure {
  FileUploadFailure(String message) : super(message);
}
