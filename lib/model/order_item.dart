import 'package:travelapp/model/place.dart';

class OrderItem {
  Place place;

  /// Selected size of place; This can be null
  String? selectedSize;

  /// Selected color of place; This can be null

  OrderItem({required this.place, this.selectedSize});
}
