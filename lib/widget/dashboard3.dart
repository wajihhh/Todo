// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:http/http.dart' as http;
//
// import '../config.dart';
//
//
//
// class Dashboard extends StatefulWidget {
//   final String token;
//
//   const Dashboard({super.key, required this.token});
//
//   @override
//   State<Dashboard> createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   TextEditingController _todoTitle = TextEditingController();
//   TextEditingController _todoDescription = TextEditingController();
//   List? items;
//
//   late String userId;
//
//   @override
//   void initState() {
//     super.initState();
//     Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
//
//     userId = jwtDecodedToken['_id'];
//     getTodoList(userId);
//   }
//
//   void addTodo() async {
//     if (_todoTitle.text.isNotEmpty && _todoDescription.text.isNotEmpty) {
//       var regBody = {
//         "userId": userId,
//         'title': _todoTitle.text,
//         'description': _todoDescription.text,
//       };
//       var response = await http.post(Uri.parse(ApiConstants.addTodo),
//           headers: {"Content-Type": "application/json"},
//           body: jsonEncode(regBody));
//       var jsonResponse = jsonDecode(response.body);
//       print(jsonResponse['status']);
//       if (jsonResponse['status']) {
//         _todoTitle.clear();
//         _todoDescription.clear();
//
//         Navigator.pop(context);
//         getTodoList(userId);
//       } else {
//         print('something went wrong');
//       }
//     }
//   }
//
//   void getTodoList(String userId) async {
//     var regBody = {
//       "userId": userId,
//     };
//     var response = await http.post(Uri.parse(ApiConstants.getTodoList),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(regBody));
//     var jsonResponse = jsonDecode(response.body);
//     items = jsonResponse['success'];
//     setState(() {});
//   }
//
//   void deleteItem(String id) async {
//     print(id);
//     var regBody = {
//       "id": id,
//     };
//     var response = await http.post(Uri.parse(ApiConstants.deleteTodo),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(regBody));
//     var jsonResponse = jsonDecode(response.body);
//     if (jsonResponse['status']) {
//       getTodoList(userId);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: EdgeInsets.only(
//                   top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     child: Icon(
//                       Icons.list,
//                       size: 30.0,
//                     ),
//                     backgroundColor: Colors.white,
//                     radius: 30.0,
//                   ),
//                   SizedBox(height: 10.0),
//                   Text(
//                     'ToDo with NodeJS + Mongodb',
//                     style:
//                     TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
//                   ),
//                   SizedBox(height: 8.0),
//                   Text(
//                     '${items?.length ?? 0} Task(s)',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//                 child: Container(
//                   height: 300,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: Padding(
//                     padding: EdgeInsets.all(5),
//                     child: items == null
//                         ? Center(child: CircularProgressIndicator())
//                         : ListView.builder(
//                         itemCount: items!.length,
//                         itemBuilder: (context, int index) {
//                           return Slidable(
//                             key: ValueKey(items![index]['_id']),
//                             endActionPane: ActionPane(
//                               motion: ScrollMotion(),
//                               dismissible: DismissiblePane(
//                                 onDismissed: () {
//                                   deleteItem('${items![index]['_id']}');
//                                   setState(() {
//                                     items!.removeAt(index);
//                                   });
//                                 },
//                               ),
//                               children: [
//                                 SlidableAction(
//                                   backgroundColor: Colors.grey,
//                                   foregroundColor: Colors.white,
//                                   icon: Icons.delete,
//                                   label: "Delete",
//                                   onPressed: (BuildContext context) {
//                                     deleteItem('${items![index]['_id']}');
//                                     setState(() {
//                                       items!.removeAt(index);
//                                     });
//                                   },
//                                 )
//                               ],
//                             ),
//                             child: Card(
//                               borderOnForeground: false,
//                               child: ListTile(
//                                 leading: Icon(Icons.task),
//                                 title: Text(
//                                   "${items![index]['title']}",
//                                 ),
//                                 subtitle: Text(
//                                   "${items![index]['description']}",
//                                 ),
//                                 trailing: Icon(Icons.arrow_back),
//                               ),
//                             ),
//                           );
//                         }),
//                   ),
//                 ))
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _displayTextInputDialog(context),
//         tooltip: 'Add-ToDo',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   Future<void> _displayTextInputDialog(BuildContext context) async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text("Add todo"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: _todoTitle,
//                   keyboardType: TextInputType.text,
//                   decoration: const InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       hintText: 'Title',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       )),
//                 ),
//                 TextField(
//                   controller: _todoDescription,
//                   keyboardType: TextInputType.text,
//                   decoration: const InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       hintText: 'Description',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       )),
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       addTodo();
//                       print('add');
//                     },
//                     child: const Text('Add'))
//               ],
//             ),
//           );
//         });
//   }
// }



