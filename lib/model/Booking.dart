class Booking {
  String? id;
  String? userId;
  String? placeId;
  int? quantity;
  int? totalPrice;
  int? status;
  String? checkInTime;
  String? checkOutTime;
  String? createdAt;
  String? updatedAt;
  int? rating;

  Booking(
      {this.id,
      this.userId,
      this.placeId,
      this.quantity,
      this.totalPrice,
      this.status,
      this.checkInTime,
      this.checkOutTime,
      this.createdAt,
      this.updatedAt,
      this.rating});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    placeId = json['placeId'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    status = json['status'];
    checkInTime = json['checkInTime'];
    checkOutTime = json['checkOutTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['placeId'] = this.placeId;
    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
    data['status'] = this.status;
    data['checkInTime'] = this.checkInTime;
    data['checkOutTime'] = this.checkOutTime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['rating'] = this.rating;
    return data;
  }

  static List<Booking> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Booking.fromJson(json)).toList();
  }
}
