import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRecipeController extends GetxController {

  int categoryIndex = 0;

  List numberByCategory = [].obs;

  bool searchMode = false;

  @override
  void onInit() {
    super.onInit();
    // fetchData();
  }

  
}