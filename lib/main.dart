import 'package:flutter/material.dart';
import 'package:appresto/model/restaurants.dart';
import 'dart:convert';
import 'dart:core';

import 'detailrestaurant.dart';
import 'donerestaurants.dart';

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

class RestaurantListPage extends StatefulWidget {
  static const routeName='restaurant_list';
  final List<Restaurants> doneRestaurantsList;

  const RestaurantListPage({Key? key, required this.doneRestaurantsList}): super(key:key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  // final String title;
  final List<Restaurants> doneRestaurantsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Restaurant App"),
        actions: <Widget>[
          IconButton(onPressed: (){
            Navigator.pushNamed(context, DoneRestaurantsListPage.routeName);
          }, icon: Icon(Icons.done))
        ],
      ),
      body: RestaurantList(doneRestaurantsList: doneRestaurantsList),

    );
  }

  // @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

// stateless => stateful == supaya bisa nambah variable
// class RestaurantList extends StatefulWidget
class RestaurantList extends StatefulWidget{
  final List<Restaurants> doneRestaurantsList;
  const RestaurantList({Key ? key, required doneRestaurantsList, required this.doneRestaurantsList}):super(key :key);
  @override
  State<RestaurantList> createState()=> _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList>{
  // const RestaurantList({Key? key}): super (key:key);
  final List<Restaurants> _doneRestaurants = const [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      //DefaultAssetBundle == widget yang membaca data yang kita berikan
      future: DefaultAssetBundle.of(context).loadString('local_restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurants> restaurants = parseRestaurants(snapshot.data);
        return ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            // return restaurantItem(restaurants[index]);
            return restaurantItem(
                resto: restaurants[index],
                isDone: _doneRestaurants.contains(restaurants[index]),
                onClick: (){
                  setState(() {
                    _doneRestaurants.add(restaurants[index]);
                  });
                },
            );
          }
        );
      },
    );
  }
}

class restaurantItem extends StatelessWidget{
  final Restaurants resto;
  final bool isDone;
  // final function() onClick;
  final Function() onClick;
  const restaurantItem({
    Key? key
    , required this.resto
    , required this.isDone
    , required this.onClick
  }):super(key:key);

  @override
  Widget build(BuildContext context) {
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
           trailing: isDone? const Icon(Icons.done) :
            ElevatedButton(
             child: Text("Done"),
             onPressed: onClick,
           ),
           onTap: () {
              Navigator.pushNamed(context, DetailRestaurantPage.routeName,arguments: resto);
           },
        ),
    );
  }
}

List<Restaurants> parseRestaurants(String? data){
  if (data==null){
    return [];
  }
  final List parsed=jsonDecode(data)['restaurants'];
  return parsed.map((data)=>Restaurants.fromJson(data)).toList();
}
