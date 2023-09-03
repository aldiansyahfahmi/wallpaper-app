class ApiResponse<T> {
  ApiResponse({
    this.status,
    this.code,
    this.message,
    this.data,
    this.meta,
    required this.onDeserialized,
  });

  String? status;
  int? code;
  String? message;
  T? data;
  Meta? meta;
  late T Function(dynamic) onDeserialized;

  ApiResponse.fromJson(
    Map<String, dynamic> json, {
    required T Function(dynamic) onDataDeserialized,
  }) {
    onDeserialized = onDataDeserialized;
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? onDeserialized(json['data']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class Meta {
  Meta({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
      );
}
