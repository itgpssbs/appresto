import 'package:flutter/material.dart';
import 'model/restaurants.dart';

class DetailRestaurantPage extends StatelessWidget{
  static const routeName = "/restaurant_detail";
  final Restaurants resto;
  const DetailRestaurantPage({Key? key, required this.resto}) : super (key:key);

  @override
  Widget build(BuildContext context) {
    // TODO : implemend build
    return Scaffold(
        appBar: AppBar(
          title: const Text('News'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(resto.pictureId),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(resto.description),
                      const Divider(color: Colors.grey,),
                      Text(
                        resto.name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                            fontSize: 24
                        ),
                      ),
                      const Divider(color: Colors.grey,),
                      Text(resto.city),
                      // Text('Date: ${resto.publishedAt}', ),
                      const SizedBox(height: 10),
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}