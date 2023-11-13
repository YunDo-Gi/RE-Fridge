import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:re_fridge/controllers/pantry_controller.dart';

const List<String> categorys = <String>[
  'All',
  'Vegetables',
  'Meat',
  'Fish / Seafood',
  'Dairy / Egg',
];

class Pantry extends StatelessWidget {
  Pantry({Key? key}) : super(key: key);
  final pantryController = Get.put(PantryController());
  final editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int tabsCount = categorys.length;

    return DefaultTabController(
        length: tabsCount,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 1;
            },
            scrolledUnderElevation: 0.0,
            title: Text('Pantry'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: categorys[0],
                ),
                Tab(
                  text: categorys[1],
                ),
                Tab(
                  text: categorys[2],
                ),
                Tab(
                  text: categorys[3],
                ),
                Tab(
                  text: categorys[4],
                ),
              ],
            ),
          ),
          body: Container(
            child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),Expanded(child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
            child: GetX<PantryController>(
              builder: (controller) {
                return TabBarView(
                  children: <Widget>[
                    // All
                    ListView.builder(
                      itemCount: controller.ingredients.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(Icons.food_bank),
                            title: Text(
                                controller.ingredients[index].ingredientName),
                            subtitle: Text(controller
                                .ingredients[index].expiryDate
                                .toString()),
                            subtitleTextStyle: TextStyle(color: Colors.red),
                            trailing: Text(controller
                                .ingredients[index].quantity
                                .toString()),
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          ),
                        );
                      },
                    ),
                    // Vegetable
                    ListView.builder(
                      itemCount: controller.ingredients.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(Icons.food_bank),
                            title: Text(
                                controller.ingredients[index].ingredientName),
                            subtitle: Text(controller
                                .ingredients[index].expiryDate
                                .toString()),
                            subtitleTextStyle: TextStyle(color: Colors.red),
                            trailing: Text(controller
                                .ingredients[index].quantity
                                .toString()),
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          ),
                        );
                      },
                    ),
                    // Meat
                    ListView.builder(
                      itemCount: controller.ingredients.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(Icons.food_bank),
                            title: Text(
                                controller.ingredients[index].ingredientName),
                            subtitle: Text(controller
                                .ingredients[index].expiryDate
                                .toString()),
                            subtitleTextStyle: TextStyle(color: Colors.red),
                            trailing: Text(controller
                                .ingredients[index].quantity
                                .toString()),
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          ),
                        );
                      },
                    ),
                    // Fish / Seafood
                    ListView.builder(
                      itemCount: controller.ingredients.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(Icons.food_bank),
                            title: Text(
                                controller.ingredients[index].ingredientName),
                            subtitle: Text(controller
                                .ingredients[index].expiryDate
                                .toString()),
                            subtitleTextStyle: TextStyle(color: Colors.red),
                            trailing: Text(controller
                                .ingredients[index].quantity
                                .toString() + ' g'),
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          ),
                        );
                      },
                    ),
                    // Dairy / Egg
                    ListView.builder(
                      itemCount: controller.ingredients.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(Icons.food_bank),
                            title: Text(
                                controller.ingredients[index].ingredientName),
                            subtitle: Text(controller
                                .ingredients[index].expiryDate
                                .toString()),
                            subtitleTextStyle: TextStyle(color: Colors.red),
                            trailing: Text(controller
                                .ingredients[index].quantity
                                .toString()),
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          ),
                        );
                      },
                    )
                  ],
                );
              },
            ),
          ),
          )],),)
          
        ));
  }
}
