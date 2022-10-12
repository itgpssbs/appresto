import 'dart:convert';

import 'package:flutter/material.dart';
import 'detailrestaurant.dart';
import 'model/restaurants.dart';

class DoneRestaurantsListPage extends StatelessWidget {
  static const routeName='restaurant_done';
  final List<Restaurants> doneRestaurantsList;

  const DoneRestaurantsListPage({Key? key, this.doneRestaurantsList}): super(key:key);
  // final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Restaurant App"),
      ),
      body: FutureBuilder<String>(
        //DefaultAssetBundle == widget yang membaca data yang kita berikan
        future: DefaultAssetBundle.of(context).loadString('local_restaurant.json'),
        builder: (context, snapshot) {
          final List<Restaurants> restaurants = parseRestaurants(snapshot.data);
          return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return _buildRestaurantItem(context, restaurants[index]);
              }
          );
        },
      ),

    );
  }

  // @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}


Widget _buildRestaurantItem(BuildContext context, Restaurants resto) {
  return Material (
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        resto.pictureId,
        width: 100,
      ),
      title: Text(resto.name),
      subtitle: Column(
        children: [
          Row(
            children: [
              Icon(Icons.add_location),
              Text(resto.city),
            ],
          ),
          Row(
            children: [
              Icon(Icons.star),
              Text(resto.rating.toString()),
            ],
          ),
        ],
      ),
      trailing: ElevatedButton(
        child: Text("Done"),
        onPressed: (){

        },
      ),
      onTap: () {
        Navigator.pushNamed(context, DetailRestaurantPage.routeName,arguments: resto);
      },
    ),
  );
}

List<Restaurants> parseRestaurants(String? data){
  if (data==null){
    return [];
  }
  final List parsed=jsonDecode(data)['restaurants'];
  return parsed.map((data)=>Restaurants.fromJson(data)).toList();
}
