import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:re_fridge/controllers/tag_controller.dart';
import 'package:re_fridge/controllers/recipe_controller.dart';
import 'package:re_fridge/colors.dart';
import 'package:re_fridge/models/tag.dart';
import 'package:re_fridge/widgets/tag_chip.dart';
import 'package:re_fridge/widgets/tag_chip_fixed.dart';

class AddRecipeDialog extends StatelessWidget {
  AddRecipeDialog({Key? key}) : super(key: key);
  final tagController = Get.put(TagController());
  final recipeController = Get.put(RecipeController());
  late FToast fToast;

  @override
  Widget build(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
    String? recipeName;

    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Change the border radius here
      ),
      title: Text('Add Recipe',
          style: TextStyle(
              color: PRIMARY_COLOR, fontWeight: FontWeight.w700, fontSize: 24)),
      content: Container(
        // constraints: BoxConstraints(
        //   minHeight: MediaQuery.of(context).size.height * 0.25,
        //   maxHeight: MediaQuery.of(context).size.height * 0.25,
        // ),
        width: MediaQuery.of(context).size.width * 0.75,
        // height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recipe Name',
                style: TextStyle(
                    color: Color.fromRGBO(54, 40, 34, 0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              TextField(
                decoration: InputDecoration(
                  isDense: true,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: PRIMARY_COLOR),
                  ),
                ),
                cursorColor: PRIMARY_COLOR,
                onChanged: (value) {
                  recipeName = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24.0, 0, 0),
                child: Text(
                  'Ingredients',
                  style: TextStyle(
                      color: Color.fromRGBO(54, 40, 34, 0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                child: DropdownMenu<Tag>(
                  width: MediaQuery.of(context).size.width * 0.75,
                  controller: tagController.searchController,
                  enableFilter: true,
                  requestFocusOnTap: true,
                  leadingIcon: const Icon(Icons.search),
                  hintText: "Search..",
                  inputDecorationTheme: InputDecorationTheme(
                    contentPadding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                    prefixIconColor: PRIMARY_COLOR,
                    suffixIconColor: PRIMARY_COLOR,
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(54, 40, 34, 0.3),
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    filled: true,
                    fillColor: Color.fromRGBO(54, 40, 34, 0.1),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  dropdownMenuEntries: [
                    for (var tag in tagController.tagsSelectable)
                      DropdownMenuEntry(
                        label: tag.ingredientName,
                        value: tag,
                        leadingIcon:
                            Image.network(tag.icon, width: 24, height: 24),
                        style: ButtonStyle(textStyle: MaterialStateProperty.all(TextStyle(fontFamily: 'Baloo2', fontWeight: FontWeight.w500, color: TEXT_COLOR, fontSize: 16))),
                      )
                  ]
                  // tagController.tagsToSelect
                  //     .map<DropdownMenuEntry<Tag>>((Tag tag) {
                  //   return DropdownMenuEntry(
                  //     label: tag.ingredientName,
                  //     value: tag,
                  //     leadingIcon: Image.network(tag.icon, width: 24, height: 24),
                  //     style: ButtonStyle(),
                  //   );
                  // }).toList()
                  ,
                  onSelected: (Tag? tag) {
                    if (tag != null) {
                      tagController.addTag(tag);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                child: Container(
                  child: GetBuilder<TagController>(
                    builder: (tagController) {
                      return tagController.tagsSelected.length > 0
                          ? Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: [
                                for (var i = 0;
                                    i < tagController.tagsSelected.length;
                                    i++)
                                  TagChip(index: i)
                              ],
                            )
                          : Text(
                              'No ingredients added',
                              style: TextStyle(
                                  color: TEXT_COLOR.withOpacity(0.3),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            );
                    },
                  ),
                ),
              ),
            ]),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(32.0, 0, 32.0, 16.0),
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              if (recipeName == null || recipeName == '') {
                showToast(recipeNameWarningToast, 200);
              } else {
                if (tagController.tagsSelected.length > 0) {
                  await tagController.addToRecipeList(
                      recipeName!, tagController.tagsSelected);
                  showToast(successToast, 102);
                  Navigator.pop(context);
                  await Future.delayed(Duration(seconds: 1), () {
                    // remove added tags
                    tagController.tagsSelected.clear();
                    tagController.reloadTags();
                  });
                } else {
                  showToast(ingredientWarningToast, 200);
                }
              }
            },
            child: Text('Confirm',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
        )
      ],
    );
  }

  void showToast(Widget toast, double bottom) {
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(child: child, bottom: bottom, left: 0, right: 0);
        });
  }
}

Widget recipeNameWarningToast = Container(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    color: Color.fromARGB(220, 254, 73, 73),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.warning_amber_rounded, color: Colors.white),
      SizedBox(
        width: 12.0,
      ),
      Text("Add recipe name to progress",
          style: TextStyle(color: Colors.white)),
    ],
  ),
);

Widget ingredientWarningToast = Container(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    color: Color.fromARGB(220, 254, 73, 73),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.warning_amber_rounded, color: Colors.white),
      SizedBox(
        width: 12.0,
      ),
      Text("Add ingredients to progress",
          style: TextStyle(color: Colors.white)),
    ],
  ),
);

Widget successToast = Container(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    color: Color.fromARGB(220, 143, 180, 78),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.check_circle_outline, color: Colors.white),
      SizedBox(
        width: 12.0,
      ),
      Text("Successfully Added", style: TextStyle(color: Colors.white)),
    ],
  ),
);
