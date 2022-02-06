import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_app/login/login.dart';
import 'package:provider/provider.dart';
import 'package:social_app/regisration/registartion_provider.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context,register,_) {
        return ModalProgressHUD(
          inAsyncCall: register.isLoading,
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
                    margin: EdgeInsets.only(top: 1, bottom: 12),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 30),
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
                          context.read<RegisterProvider>().getName(value),
                      decoration: InputDecoration(
                          labelText: '  Name',
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
                          context.read<RegisterProvider>().getUsername(value),
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
                          context.read<RegisterProvider>().getPassword(value),
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
                            onPressed: () =>
                                Provider.of<RegisterProvider>(context, listen: false)
                                    .register(context),
                            child: Text('Register'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => LoginScreen())),
                      child: Text(
                        'Go to login screen',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
