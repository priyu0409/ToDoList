import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todotask/Controller/DashboardController.dart';
import 'package:todotask/Model/TsakModel.dart';

import '../Controller/CreateTaskController.dart';

const List<String> list = <String>['P0', 'P1', 'P2', 'P3'];

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final CreateTaskController controller = Get.put(CreateTaskController());
  final DashboardController dashcontroller = Get.put(DashboardController());
  final datacount = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Task"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: controller.title,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
                hintText: 'Enter Title',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: controller.description,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
                hintText: 'Enter Description',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: controller.duedate,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Due Date',
                hintText: 'Enter Due Date',
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                value: controller.dropdownValue.value,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (String? value) {
                  controller.dropdownValue.value = value as String;
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          Container(
            margin: EdgeInsets.all(10),
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  primary: Colors.teal,
                ),
                onPressed: () {
                  if (Get.arguments != null) {
                    controller.taskdata.title = controller.title.value.text;
                    controller.taskdata.description =
                        controller.description.value.text;
                    controller.taskdata.duedate = controller.duedate.value.text;
                    controller.taskdata.priority =
                        controller.dropdownValue.value;
                    var a = Get.arguments;
                    final index = dashcontroller.todolist.indexOf(a);
                    dashcontroller.todolist[index] = controller.taskdata;
                  } else {
                    controller.taskdata.title = controller.title.value.text;
                    controller.taskdata.description =
                        controller.description.value.text;
                    controller.taskdata.duedate = controller.duedate.value.text;
                    controller.taskdata.priority =
                        controller.dropdownValue.value;
                    dashcontroller.todolist.add(controller.taskdata);
                  }
                  var paymentsAsMap = dashcontroller.todolist
                      .map((payment) => payment.toJson())
                      .toList();
                  String jsonString = jsonEncode(paymentsAsMap);
                  datacount.erase();
                  datacount.write("tododata", jsonString);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Get.back();
                  });
                },
                child: const Text('Submit')),
          ),
        ],
      ),
    );
  }
}
