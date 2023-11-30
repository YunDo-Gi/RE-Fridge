import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:re_fridge/colors.dart';

import 'package:re_fridge/controllers/pantry_controller.dart';
import 'package:re_fridge/controllers/add_item_controller.dart';
import 'package:re_fridge/widgets/ingredient_card.dart';

const List<String> categorys = <String>[
  'All',
  'Vegetable',
  'Meat',
  'Fish / Seafood',
  'Dairy / Egg',
];

class AddItem extends StatelessWidget {
  final addItemController = Get.put(AddItemController());

  @override
  Widget build(BuildContext context) {
    int tabsCount = categorys.length;

    return DefaultTabController(
        length: tabsCount,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(245, 236, 220, 1),
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: TEXT_COLOR, //change your color here
            ),
            backgroundColor: Colors.white,
            centerTitle: false,
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 1;
            },
            scrolledUnderElevation: 0.0,
            title: Text('Add Item',
                style: TextStyle(
                    color: Color.fromRGBO(54, 40, 34, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 30)),
            bottom: TabBar(
              indicatorColor: Color.fromRGBO(142, 180, 78, 1),
              labelColor: Color.fromRGBO(54, 40, 34, 1),
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
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
                      addItemController.filterIngredient(value);
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
                  child: GetX<AddItemController>(
                    builder: (controller) {
                      return TabBarView(
                        children: <Widget>[
                          // All
                          GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1.0,
                            ),
                            itemCount: controller.foundIngredients.length,
                            itemBuilder: (context, index) {
                              return IngredientCard(index: index);
                            },
                          ),
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
