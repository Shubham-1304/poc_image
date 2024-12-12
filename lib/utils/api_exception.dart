class APIException{
  const APIException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;
} 