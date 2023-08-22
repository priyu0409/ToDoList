import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todotask/Controller/DashboardController.dart';
import 'package:todotask/Model/TsakModel.dart';
import 'package:todotask/Screen/CreateTask.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardController controller = Get.put(DashboardController());

  Widget createDummyWidget(Task data) {
    return GestureDetector(
      onTap: () => {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Task Detail"),
                content: Container(
                  height: 150,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Title : '),
                          Text(data.title.toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Description : '),
                          Text(data.description.toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Due Date : '),
                          Text(data.duedate.toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Priority : '),
                          Text(data.priority.toString()),
                        ],
                      )
                    ],
                  ),
                ),
              );
            })
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.amber[100]),
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            GestureDetector(
              onTap: (() => {controller.todolist.remove(data)}),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Delete'),
                ],
              ),
            ),
            GestureDetector(
              onTap: (() => {
                    Get.to(
                      () => const CreateTask(),
                      arguments: data,
                    )
                  }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Edit'),
                ],
              ),
            ),
            Row(
              children: [
                Text('Title : '),
                Text(data.title.toString()),
              ],
            ),
            Row(
              children: [
                Text('Priority : '),
                Text(data.priority.toString()),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo task list"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            child: TextField(
              controller: controller.searchtext,
              onChanged: (value) => {
                if (value.trim() == '')
                  {controller.searchdata = controller.todolist}
                else
                  {
                    controller.searchdata.clear(),
                    controller.searchdata = controller.todolist
                        .where((element) => element.title!
                            .startsWith(controller.searchtext.text))
                        .toList()
                  }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // labelText: 'Due Date',
                hintText: 'Search here',
              ),
            ),
          ),
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
                  Get.to(const CreateTask(), arguments: null);
                },
                child: const Text('Create task')),
          ),
          Obx(() => Column(
                children: <Widget>[
                  for (var item in controller.todolist) createDummyWidget(item)
                ],
              ))
        ],
      ),
    );
  }
}
