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
      'Name': name,
      'Description': description,
      'Image': image,
      'Rating': rating,
      'Location': location,
      'Price': price,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      name: map['Name'] as String,
      description: map['Description'] as String,
      image: map['Image'] as String,
      rating: map['Rating'] as String,
      location: map['Location'] as String,
      price: map['Price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source) as Map<String, dynamic>);
}
