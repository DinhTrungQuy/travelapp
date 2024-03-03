class Wishlist {
  String? id;
  String? userId;
  String? placeId;

  Wishlist({this.id, this.userId, this.placeId});

  Wishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    placeId = json['placeId'];
  }
  static List<Wishlist> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Wishlist.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['placeId'] = this.placeId;
    return data;
  }
}
