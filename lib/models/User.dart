// 用户实体类
class User {
  String? userName;
  String? password;

  User({this.userName, this.password});

  User.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userName'] = userName;
    data['password'] = password;
    return data;
  }
}
