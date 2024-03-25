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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['placeId'] = placeId;
    data['quantity'] = quantity;
    data['totalPrice'] = totalPrice;
    data['status'] = status;
    data['checkInTime'] = checkInTime;
    data['checkOutTime'] = checkOutTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['rating'] = rating;
    return data;
  }

  static List<Booking> fromJsonList(List<dynamic> jsonList) {
    List<Booking> sortedList =
        jsonList.map((json) => Booking.fromJson(json)).toList();
    sortedList.sort((a, b) => a.status!.compareTo(b.status!));
    return sortedList;
  }
}
