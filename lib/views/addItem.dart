import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:re_fridge/colors.dart';

import 'package:re_fridge/controllers/pantry_controller.dart';
import 'package:re_fridge/widgets/ingredient_card.dart';

const List<String> categorys = <String>[
  'All',
  'Vegetable',
  'Meat',
  'Fish / Seafood',
  'Dairy / Egg',
];

const List<String> categorysIcon = <String>[
  'assets/icons/vegetable.png',
  'assets/icons/meat.png',
  'assets/icons/fish.png',
  'assets/icons/dairy.png',
  'assets/icons/egg.png',
];

class Ingredient {
  final String name;
  final String category;
  final String icon;

  Ingredient({required this.name, required this.category, required this.icon});
}

List<Ingredient> ingredients = [
  Ingredient(name: 'Carrot', category: 'Vegetable', icon: 'assets/icons/vegetable.png'),
  Ingredient(name: 'Chicken', category: 'Meat', icon: 'assets/icons/meat.png'),
  Ingredient(name: 'Salmon', category: 'Fish / Seafood', icon: 'assets/icons/fish.png'),
  Ingredient(name: 'Milk', category: 'Dairy / Egg', icon: 'assets/icons/dairy.png'),
  Ingredient(name: 'Egg', category: 'Dairy / Egg', icon: 'assets/icons/egg.png'),
];


class AddItem extends StatelessWidget {
  final pantryController = Get.put(PantryController());

  @override
  Widget build(BuildContext context) {
     int tabsCount = categorys.length;
    
    return DefaultTabController(
        length: tabsCount,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(245, 236, 220, 1),
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 1;
            },
            scrolledUnderElevation: 0.0,
            title: Text('Pantry',
                style: TextStyle(
                    color: Color.fromRGBO(54, 40, 34, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 30)),
            actions: [
              IconButton(
                icon: Icon(Icons.add_circle_outline_rounded),
                color: Color.fromRGBO(54, 40, 34, 1),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddItem()),
                  );
                },
              )
            ],
            bottom: TabBar(
              indicatorColor: Color.fromRGBO(142, 180, 78, 1),
              labelColor: Color.fromRGBO(54, 40, 34, 1),
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              onTap: (index) {
                // pantryController.categoryIndex.value = index;
                pantryController.categorizeIngredient(index);
              },
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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: TextField(
                    onChanged: (value) {
                      pantryController.filterIngredient(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      suffixIcon: Icon(Icons.search,
                          color: Color.fromRGBO(54, 40, 34, 0.3)),
                      hintText: "Search..",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(54, 40, 34, 0.3),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      filled: true,
                      fillColor: Color.fromRGBO(54, 40, 34, 0.1),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                  child: GetX<PantryController>(
                    builder: (controller) {
                      return TabBarView(
                        children: <Widget>[
                          // All
                          ListView.builder(
                            itemCount: controller.foundIngredients.length,
                            itemBuilder: (context, index) {
                              return IngredientCard(
                              );
                            },
                          ),
                          // // Vegetable
                          // ListView.builder(
                          //   itemCount: controller.numberByCategory[0],
                          //   itemBuilder: (context, index) {
                          //     return PantryItem(index: index);
                          //   },
                          // ),
                          // // Meat
                          // ListView.builder(
                          //   itemCount: controller.numberByCategory[1],
                          //   itemBuilder: (context, index) {
                          //     return PantryItem(index: index);
                          //   },
                          // ),
                          // // Fish / Seafood
                          // ListView.builder(
                          //   itemCount: controller.numberByCategory[2],
                          //   itemBuilder: (context, index) {
                          //     return PantryItem(index: index);
                          //   },
                          // ),
                          // // Dairy / Egg
                          // ListView.builder(
                          //   itemCount: controller.numberByCategory[3],
                          //   itemBuilder: (context, index) {
                          //     return PantryItem(index: index);
                          //   },
                          // )
                        ],
                      );
                    },
                  ),
                )),
              ],
            ),
          ),
        ));
  }
}