import 'package:appresto/model/restaurants.dart';

import 'foods.dart';
import 'drinks.dart';

class Menus {
  List<Foods> foods;
  List<Drinks> drinks;

  Menus({required this.foods, required this.drinks});

  // factory constroctor == create dirinya sendiri
  // fromJson == nama constructor
  factory Menus.fromJson(Map<String, dynamic> json) {
    // final = gak bisa diisi lagi kalau kosong
    final foods = <Foods>[];
    if (json['foods'] != null) {
      json['foods'].forEach((v) {
        foods.add(Foods.fromJson(v));
      });
    }
    final drinks = <Drinks>[];
    if (json['drinks'] != null) {
      json['drinks'].forEach((v) {
        drinks.add(Drinks.fromJson(v));
      });
    }
    return Menus(foods: foods, drinks:drinks);
  }

  // toJson == nama fungsi
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (foods != null) {
      data['foods'] = foods.map((v) => v.toJson()).toList();
    }
    if (drinks != null) {
      data['drinks'] = drinks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
