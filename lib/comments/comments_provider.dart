import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/contants.dart';
import 'package:social_app/login/login_provider.dart';
import 'package:http/http.dart' as http;

class CommentProvider extends ChangeNotifier {
  String? _commentText;
  LoginProvider login = LoginProvider();

  String get commentText => _commentText!;

  getCommentText(String text) {
    _commentText = text;
    notifyListeners();
  }

  addComment(String postId, BuildContext context) async {
    await login.getUser();
    var data = {"postid": postId, "body": commentText, "user": login.user!.id};

    var response = await http.post(Uri.parse(url + "post/comment"),
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Success Post',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      print(response.body);
    }
  }
}
