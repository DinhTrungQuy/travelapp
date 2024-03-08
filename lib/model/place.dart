
class Place {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String rating;
  final String location;
  final int price;
  final int durationDays;
  final bool popular;
  final bool recommended;
  final int direction;
  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.location,
    required this.price,
    required this.durationDays,
    required this.popular,
    required this.recommended,
    required this.direction,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      rating: json['rating'],
      location: json['location'],
      price: json['price'],
      durationDays: json['durationDays'],
      popular: json['popular'],
      recommended: json['recommended'],
      direction: json['direction'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'location': location,
      'price': price,
      'durationDays': durationDays,
      'popular': popular,
      'recommended': recommended,
      'direction': direction,
    };
  }
}
