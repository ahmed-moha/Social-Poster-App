import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/contants.dart';
import 'package:social_app/login/login_provider.dart';
import 'package:social_app/posts/post_model.dart';
import 'package:http/http.dart' as http;

class PostsProvider extends ChangeNotifier {
  List<PostsModel> posts = [];
  bool isLoading=false;
  String? _postText;
  LoginProvider login = LoginProvider();
  String get postText => _postText!;

  getPostText(String text) {
    _postText = text;
    notifyListeners();
  }

  getPosts() async {
    var response = await http.get(Uri.parse(url + 'post'));
    if (response.statusCode == 200) {
      print(response.body);
      List decodedData = jsonDecode(response.body);
      posts = decodedData.map((e) => PostsModel.fromJson(e)).toList();
      notifyListeners();
    } else {
      print(response.body);
    }
  }

  addPost(BuildContext context) async {
    isLoading=true;
    notifyListeners();
    await login.getUser();
    var data = {"body": postText, "user": login.user!.id};

    var response = await http.post(Uri.parse(url + "post"),
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      print(response.body);
      getPosts();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Success Comment',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      print(response.body);
    }

    isLoading=false;
    notifyListeners();
  }
}
