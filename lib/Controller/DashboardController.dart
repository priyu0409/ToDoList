import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todotask/Model/TsakModel.dart';

class DashboardController extends GetxController {
  List<Task> todolist = <Task>[].obs;
  final search = false.obs;
  final searchtext = TextEditingController();
  List<Task> searchdata = <Task>[].obs;
  final datacount = GetStorage();
}
