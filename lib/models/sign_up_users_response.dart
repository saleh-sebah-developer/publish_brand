import 'login_for_users_response.dart';

class SignUpUsersResponse {
  bool status = true;
  int code;
  String message;
  User user;

  SignUpUsersResponse({this.status=true, this.code, this.message, this.user});

  SignUpUsersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (user != null) {
      data['user'] = user.toJson();
    }
    return data;
  }
}
/*
class User {
  String name;
  String email;
  String mobile;
  String phone;
  String address;
  String latitude;
  String longitude;
  String type;
  String createdAt;
  int id;

  User(
      {this.name,
        this.email,
        this.mobile,
        this.phone,
        this.address,
        this.latitude,
        this.longitude,
        this.type,
        this.createdAt,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    phone = json['phone'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    type = json['type'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['phone'] = phone;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
*/