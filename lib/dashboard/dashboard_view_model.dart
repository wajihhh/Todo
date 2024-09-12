import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../token_manager.dart';

class DashboardViewModel extends GetxController {
  final TextEditingController todoTitle = TextEditingController();
  final TextEditingController todoDescription = TextEditingController();
  RxList<dynamic> items = <dynamic>[].obs; // Make it an observable list
  late SharedPreferences prefs;
  late String userId;
  late final token;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await _initialize();
  }

  Future<void> _initialize() async {
    prefs = await SharedPreferences.getInstance();
    token = await TokenManager().getToken(); // Fetch the token
    final jwtDecodedToken = JwtDecoder.decode(token);
    userId = jwtDecodedToken['_id'];
    getTodoList(userId);
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void addTodo() async {
    if (todoTitle.text.isNotEmpty && todoDescription.text.isNotEmpty) {
      var regBody = {
        "userId": userId,
        'title': todoTitle.text,
        'description': todoDescription.text,
      };
      var response = await http.post(
        Uri.parse(ApiConstants.addTodo),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );
      var jsonResponse = jsonDecode(response.body);
      print(
        jsonResponse['status'],
      );
      if (jsonResponse['status']) {
        todoTitle.clear();
        todoDescription.clear();

        // Navigator.pop(context);
        getTodoList(userId);
      } else {
        print('something went wrong');
      }
    }
  }

  void getTodoList(userId) async {
    var regBody = {
      "userId": userId,
    };
    var response = await http.post(
      Uri.parse(ApiConstants.getTodoList),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);
    items.value = jsonResponse['success'];
    // setState(() {});
  }

  void deleteItem(id) async {
    print(id);
    var regBody = {
      "id": id,
    };
    var response = await http.post(
      Uri.parse(ApiConstants.deleteTodo),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      getTodoList(userId);
    }
  }
}
