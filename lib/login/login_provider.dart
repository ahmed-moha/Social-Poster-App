import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/contants.dart';
import 'package:social_app/home.dart';
import 'package:social_app/login/login_model.dart';

class LoginProvider extends ChangeNotifier {
  String? _username;
  String? _password;
  LoginModel? user;
  bool isLoading = false;
  final box = GetStorage();
   LoginProvider(){
     getUser();
   }
  String get username => _username!;
  String get password => _password!;

  getUsername(String username) {
    _username = username;
    notifyListeners();
  }

  getPassword(String password) {
    _password = password;
    notifyListeners();
  }

  login(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    var data = {
      "username": username,
      "password": password,
    };

    var response = await http.post(Uri.parse(url + "user/login"),
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      user = LoginModel.fromJson(decodedData);
      print(user!.name);
      saveUser(user!);
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
    } else {
      print(response.body);
    }

    isLoading = false;
    notifyListeners();
  }

  saveUser(LoginModel user) {
    box.write(userInfo, user.toJson());
    box.write(isLoggedIn, 'isloggedio');
  }
  getUser(){
    bool hasData=box.hasData(userInfo);
    if(hasData==true){
      var data=box.read(userInfo);
      user=LoginModel.fromJson(data);
      notifyListeners();
    }else{
      return null;
    }
  }
}
