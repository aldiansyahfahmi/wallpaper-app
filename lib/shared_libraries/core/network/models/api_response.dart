class ApiResponse<T> {
  ApiResponse({
    this.page,
    this.perPage,
    this.totalResults,
    this.nextPage,
    this.prefPage,
    this.data,
    required this.onDeserialized,
  });

  int? page;
  int? perPage;
  int? totalResults;
  String? nextPage;
  String? prefPage;
  T? data;
  late T Function(dynamic) onDeserialized;

  ApiResponse.fromJson(
    Map<String, dynamic> json, {
    required T Function(dynamic) onDataDeserialized,
  }) {
    onDeserialized = onDataDeserialized;
    page = json["page"];
    perPage = json["per_page"];
    totalResults = json["total_results"];
    nextPage = json["next_page"];
    prefPage = json["pref_page"];
    data = json['photos'] != null ? onDeserialized(json['photos']) : null;
  }
}
