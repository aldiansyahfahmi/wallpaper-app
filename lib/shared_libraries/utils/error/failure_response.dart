import 'package:equatable/equatable.dart';

class FailureResponse extends Equatable {
  final String errorMessage;
  final int statusCode;

  const FailureResponse({
    required this.errorMessage,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [errorMessage, statusCode];
}

