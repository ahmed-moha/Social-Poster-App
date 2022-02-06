import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/contants.dart';
import 'package:social_app/login/login.dart';

class RegisterProvider extends ChangeNotifier {
  String? _name;
  String? _username;
  String? _password;
  bool isLoading = false;

  String get name => _name!;
  String get username => _username!;
  String get password => _password!;

  getName(String name) {
    _name = name;
    notifyListeners();
  }

  getUsername(String username) {
    _username = username;
    notifyListeners();
  }

  getPassword(String password) {
    _password = password;
    notifyListeners();
  }

  register(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    print(name);
    var data = {"name": name, "username": username, "password": password};
    var response = await http.post(Uri.parse(url + 'user'),
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    } else {
      print(response.body);
    }

    isLoading = false;
    notifyListeners();
  }
}
