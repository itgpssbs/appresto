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
          title: Text(resto.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(resto.pictureId),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resto.description,
                        maxLines: 4,
                        // overflow: TextOverFlow.ellipsis,
                      ),
                      Divider(color: Colors.grey),
                      Container(
                        width: 1000,
                        height: 100,
                        child:ListView.builder(
                          shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: resto.menus.foods.length,
                            itemBuilder: (BuildContext context,int index)=> Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Center(
                                  child: Text(resto.menus.foods[index].name.toString()),
                                ),
                              ),
                            ),
                        ),
                      ),
                      // Text(
                      //   resto.name,
                      //   style: const TextStyle(
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.w100,
                      //       fontSize: 24
                      //   ),
                      // ),
                      // const Divider(color: Colors.grey,),
                      // Text(resto.city),
                      // // Text('Date: ${resto.publishedAt}', ),
                      // const SizedBox(height: 10),
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}