import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:social_app/posts/posts_provider.dart';

class AddPosts extends StatelessWidget {
  const AddPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(
      builder: (context,posts,_) {
        return ModalProgressHUD(
          inAsyncCall: posts.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Add Post'),
              centerTitle: true,
              backgroundColor: Colors.cyan,
              elevation: 0,
            ),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(22.0),
                  child: TextField(
                    onChanged: (value) =>
                        context.read<PostsProvider>().getPostText(value),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        hintText: 'Write Post...', border: OutlineInputBorder()),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.all(22.0),
                      height: 65,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyan,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () =>Provider.of<PostsProvider>(context,listen: false).addPost(context),
                        child: Text('Submit'),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
