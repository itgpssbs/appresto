import 'package:flutter/material.dart';
import 'package:appresto/model/restaurants.dart';
import 'dart:convert';
import 'dart:core';

import 'detailrestaurant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: RestaurantListPage.routeName,
      routes: {
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
          resto: ModalRoute.of(context)?.settings.arguments as Restaurants
        ),
      },
      // home: const RestaurantListPage(),
    );
  }
}

class RestaurantListPage extends StatelessWidget {
  static const routeName='restaurant_list';
  const RestaurantListPage({Key? key}): super(key:key);
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
        subtitle: Text(resto.description),
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
