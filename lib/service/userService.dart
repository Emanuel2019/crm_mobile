import 'dart:convert';

import 'package:crm_mobile/model/userModel.dart';
import 'package:http/http.dart' as http;

class userService {
  static const ADD_URL = 'http://localhost/school/signup.php';
  static const VIEW_URL = 'http://localhost/school/view.php';
    static const UPDATE_URL = 'http://localhost/school/update.php';
  Future<String> addUser(UserModel userModel) async {
    final response =
        await http.post(Uri.parse(ADD_URL), body: userModel.toJsonAdd());
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      return "error";
    }
  }

  List<UserModel> userFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<UserModel>.from(data.map((item) => UserModel.fromJson(item)));
  }

  Future<List<UserModel>> getUser() async {
    final response = await http.get(Uri.parse(VIEW_URL));
    if (response.statusCode == 200) {
      List<UserModel> list = userFromJson(response.body);
      return list;
    } else {
      List<UserModel> list = [];
      return list;
    }
  }
  Future<String> updateUser(UserModel userModel) async {
    final response =
        await http.post(Uri.parse(UPDATE_URL), body: userModel.toJsonUpdate());
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      return "error";
    }
  }
}
