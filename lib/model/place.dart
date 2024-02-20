// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Place {
  final String name;
  final String description;
  final String image;
  final String rating;
  final String location;
  final double price;
  Place({
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.location,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'image': image,
      'rating': rating,
      'location': location,
      'price': price,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      rating: map['rating'] as String,
      location: map['location'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source) as Map<String, dynamic>);
}
