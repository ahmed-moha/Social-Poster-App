import 'package:social_app/login/login.dart';

class LoginModel {
  String? id;
  String? name;
  String? username;
  String? photo;
  String? token;

  LoginModel({this.id, this.name, this.username, this.photo, this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        id: json['_id'],
        name: json['name'],
        username: json['username'],
        photo: json['photo'],
        token: json['token']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['photo'] = photo;
    data['token'] = token;
    return data;
  }
}
