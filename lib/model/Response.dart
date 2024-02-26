class Response {
  Map<String, dynamic> data;
  final int status;
  String description;
  Response({
    required this.data,
    required this.status,
    this.description = "",
  });
  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      data: json['data'] ?? '',
      status: json['status'],
      description: json['description'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'status': status,
      'description': description,
    };
  }
}
