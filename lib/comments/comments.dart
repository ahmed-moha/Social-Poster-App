import 'package:flutter/material.dart';
import 'package:social_app/comments/comments_provider.dart';
import 'package:social_app/posts/post_model.dart';
import 'package:provider/provider.dart';
import 'package:social_app/posts/posts_provider.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({
    Key? key,
    required this.post,
  }) : super(key: key);
  final PostsModel post;
TextEditingController text=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(builder: (context, posts, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          elevation: 0,
          centerTitle: true,
          title: Text('Comments'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: post.comments!.length,
                itemBuilder: (context, index) => CommentCard(
                  text: post.comments![index].body!,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(12.0),
              child: TextField(
                controller: text,
                onChanged: (value) =>
                    context.read<CommentProvider>().getCommentText(value),
                decoration: InputDecoration(
                  hintText: 'Write Comment...',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusScopeNode());
                      text.clear();
                      post.comments!.add(
                        Comments(
                            body: Provider.of<CommentProvider>(context,
                                    listen: false)
                                .commentText),
                      );
                      Provider.of<CommentProvider>(context, listen: false)
                          .addComment(post.sId!,context);

                      Provider.of<PostsProvider>(context, listen: false)
                          .getPosts();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(1, 10), color: Colors.grey.shade100, blurRadius: 5)
      ]),
      child: Text(text),
    );
  }
}
