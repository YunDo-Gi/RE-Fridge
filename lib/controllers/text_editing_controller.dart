import 'package:get/get.dart';


class TextEditingController extends GetxController {
  final text = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void setText(String value) {
    text.value = value;
  }

  String getText() {
    return text.value;
  }
}