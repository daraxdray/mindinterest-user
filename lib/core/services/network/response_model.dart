class ApiResponse {
  ApiResponse({this.statusCode, this.body});

  int? statusCode;
  Map<String, dynamic>? body;
}
