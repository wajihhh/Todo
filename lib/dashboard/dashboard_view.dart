import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_getx/dashboard/dashboard_view_model.dart';
import '../signin/sign_in_view_model.dart';
// import '../token_manager.dart';

const Color kBackgroundColor = Colors.black;
const Color kTextColor = Colors.white;

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final SignInViewModel viewModel = Get.find<SignInViewModel>();
  final DashboardViewModel model = Get.put(DashboardViewModel());

  // final TokenManager _tokenManager = TokenManager(); // Add this line
  final GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    // final String userName = box.read('name') ?? 'User';

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          // 'Notes',
          // 'Welcome, $userName',
          'Welcome',
          style: TextStyle(color: kTextColor),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              viewModel.logout(); // Call logout method
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // FutureBuilder(
            //   future: _tokenManager.getEmail(), // Retrieve the email
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else {
            //       return Text(
            //         'Email: ${snapshot.data}', // Display the email
            //         style: const TextStyle(fontSize: 20.0),
            //       );
            //     }
            //   },
            // ),
            Container(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notes',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                  // const SizedBox(width: 8.0),
                  Obx(
                    () => Text(
                      '${model.items.length}',
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  // Obx(() => Text(
                  //   '${model.items.length} Task${model.items.length == 1 ? '' : 's'}',
                  //   style: const TextStyle(fontSize: 20,color: Colors.white),
                  // )),
                ],
              ),
            ),

            Expanded(
              child: Container(
                height: 300,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ) ,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Obx(
                    () {
                      if (model.items.isEmpty) {
                        return const Center(
                          child: Text(
                            "Empty",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: model.items.length,
                        itemBuilder: (context, int index) {
                          //---//
                          final item = model.items[index];
                          // final title = item['title'] ?? 'No Title';
                          // final description =
                          item['description'] ?? 'No Description';
                          final dateTime = item['dateTime'] != null
                              ? DateTime.parse(item['dateTime'])
                              : DateTime.now();
                          final formattedDate =
                              '${dateTime.day}/${dateTime.month}/${dateTime.year}';
                          final formattedTime =
                              '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
                          //---//
                          return Slidable(
                            key: const ValueKey(0),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(
                                onDismissed: () {
                                  model.deleteItem(model.items[index]['_id']);
                                },
                              ),
                              children: [
                                SlidableAction(
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.black,
                                  icon: Icons.delete,
                                  label: "Delete",
                                  onPressed: (BuildContext context) {
                                    model.deleteItem(
                                        '${model.items[index]['_id']}');

                                    // print('${items![index]['_id']}');
                                  },
                                )
                              ],
                            ),
                            child: Card(
                              color: Colors.white12,
                              borderOnForeground: false,
                              child: ListTile(
                                leading: const Icon(
                                  Icons.task,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  "${model.items[index]['title']}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                // subtitle: Text(
                                //   "${model.items[index]['description']}",style: TextStyle(color: Colors.grey,fontSize: 15)
                                // ),
                                //---//

                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['description'],
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                    Text(
                                      'Date: $formattedDate',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    Text(
                                      'Time: $formattedTime',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                                //---//
                                trailing: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayTextInputDialog(context, model),
        tooltip: 'Add-ToDo',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, DashboardViewModel model) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: const Text(
            "Add todo",
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: model.todoTitle,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: model.todoDescription,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                    model.addTodo();
                    print('add');
                  },
                  child: const Text('Add'))
            ],
          ),
        );
      },
    );
  }
}
