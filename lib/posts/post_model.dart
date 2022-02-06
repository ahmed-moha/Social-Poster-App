class PostsModel {
  String? sId;
  String? body;
  List<String>? likes;
  List<Comments>? comments;
  String? createdDate;
  String? name;
  String? photo;

  PostsModel(
      {this.sId,
      this.body,
      this.likes,
      this.comments,
      this.createdDate,
      this.name,
      this.photo});

  PostsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    body = json['body'];
    likes = json['likes'].cast<String>();
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    createdDate = json['created_date'];
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['body'] = this.body;
    data['likes'] = this.likes;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['created_date'] = this.createdDate;
    data['name'] = this.name;
    data['photo'] = this.photo;
    return data;
  }
}

class Comments {
  String? body;
  String? sId;
  String? createdDate;
  String? name;
  String? photo;

  Comments({this.body, this.sId, this.createdDate, this.name, this.photo});

  Comments.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    sId = json['_id'];
    createdDate = json['created_date'];
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['_id'] = this.sId;
    data['created_date'] = this.createdDate;
    data['name'] = this.name;
    data['photo'] = this.photo;
    return data;
  }
}
