import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todotask/Model/TsakModel.dart';

class CreateTaskController extends GetxController {
  final title = TextEditingController();
  final description = TextEditingController();
  final duedate = TextEditingController();
  final dropdownValue = 'P0'.obs;
  final taskdata = Task();

  @override
  void onInit() {
    if (Get.arguments != null) {
      print('ashish working');
      title.text = Get.arguments.title.toString();
      description.text = Get.arguments.description.toString();
      duedate.text = Get.arguments.duedate.toString();
      dropdownValue.value = Get.arguments.priority.toString();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    title.dispose();
    description.dispose();
    duedate.dispose();
  }
}
