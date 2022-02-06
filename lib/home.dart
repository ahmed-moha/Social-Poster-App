import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:social_app/comments/comments.dart';
import 'package:social_app/login/login.dart';
import 'package:social_app/login/login_provider.dart';
import 'package:social_app/posts/post_model.dart';
import 'package:social_app/posts/posts_provider.dart';

import 'posts/add_posts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<PostsProvider>(context, listen: false).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginProvider, PostsProvider>(
        builder: (context, login, posts, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text('Social App'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      '${login.user!.name}',
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                  ),
                  Spacer(),
                  Icon(CupertinoIcons.settings),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(CupertinoIcons.bell)
                ],
              ),
            ),
            posts.posts.isEmpty
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: posts.posts.length,
                      itemBuilder: (context, index) =>
                          PostCard(post: posts.posts[index]),
                    ),
                  ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (_)=>AddPosts())),
          backgroundColor: Colors.cyan,
          child: const Icon(Icons.post_add),
        ),
      );
    });
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);
  final PostsModel post;
  @override
  Widget build(BuildContext context) {
    var time = Jiffy(post.createdDate).fromNow();
    return Container(
      margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
                offset: Offset(1, 10),
                color: Colors.grey.shade300,
                blurRadius: 12)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                margin: EdgeInsets.only(left: 8.0, top: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image(
                    image: AssetImage('assets/images/bg.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 12.0, left: 8.0),
                    child: Text(
                      post.name!,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8.0, top: 5.0),
                    child: Text(
                      time,
                      style: TextStyle(fontSize: 10.0),
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 12.0, left: 16.0),
            alignment: Alignment.topLeft,
            child: Text(post.body!),
          ),
          Visibility(
              visible: false,
              child: Container(
                margin: EdgeInsets.all(12.0),
                width: double.infinity,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    'assets/images/login_bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.heart)),
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CommentsScreen(post: post,)),
                ),
                icon: Icon(CupertinoIcons.bubble_left),
              )
            ],
          )
        ],
      ),
    );
  }
}
