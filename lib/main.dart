import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:social_app/comments/comments_provider.dart';
import 'package:social_app/contants.dart';
import 'package:social_app/login/login.dart';
import 'package:social_app/login/login_provider.dart';
import 'package:social_app/posts/posts_provider.dart';
import 'package:social_app/regisration/registartion_provider.dart';

import 'home.dart';

void main() async {
  await GetStorage.init();
  final box=GetStorage();
  var hasData=box.hasData(isLoggedIn);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider(),
        ),
        ChangeNotifierProvider<PostsProvider>(
          create: (_) => PostsProvider(),
        ),
       ChangeNotifierProvider<CommentProvider>(
          create: (_) => CommentProvider(),
        ),
      
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:hasData?Home(): LoginScreen(),
      ),
    ),
  );
}
