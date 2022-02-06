import 'package:flutter/material.dart';
import 'package:social_app/login/login_provider.dart';
import 'package:social_app/regisration/registration.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context,user,_) {
        return ModalProgressHUD(
          inAsyncCall: user.isLoading,
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/login_bg.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: Icon(Icons.person),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    margin: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: TextField(
                      onChanged: (value) =>
                          context.read<LoginProvider>().getUsername(value),
                      decoration: InputDecoration(
                          labelText: '  Username',
                          labelStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    margin: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: TextField(
                      onChanged: (value) =>
                          context.read<LoginProvider>().getPassword(value),
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: '  Password',
                          labelStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 65,
                          margin: EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () =>Provider.of<LoginProvider>(context,listen: false).login(context),
                            child: Text('Login'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 18.0),
                        child: Text(
                          'don\'t have and account',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Registration())),
                        child: Text('Create an account'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
