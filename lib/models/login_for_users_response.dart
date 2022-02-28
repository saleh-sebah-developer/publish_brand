// ignore: camel_case_types
class LoginForUsersResponse {
  bool status = true;
  int code;
  String message;
  User user;

  LoginForUsersResponse(
      {this.status = true, this.code, this.message, this.user});

  LoginForUsersResponse.fromJson(Map<String, dynamic> json) {
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

class User {
  int id;
  String name;
  String mobile;
  String phone;
  String email;
  String provider;
  String socialToken;
  String address;
  String latitude;
  String longitude;
  String imageProfile;
  String rememberToken;
  String status;
  String type;
  String createdAt;
  String accessToken;

  User(
      {this.id,
      this.name,
      this.mobile,
      this.phone,
      this.email,
      this.provider,
      this.socialToken,
      this.address,
      this.latitude,
      this.longitude,
      this.imageProfile,
      this.rememberToken,
      this.status,
      this.type,
      this.createdAt,
      this.accessToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    phone = json['phone'];
    email = json['email'];
    // ignore: void_checks
    provider = json['provider'];
    // ignore: void_checks
    socialToken = json['social_token'];
    address = json['address'];
    // ignore: void_checks
    latitude = json['latitude'];
    // ignore: void_checks
    longitude = json['longitude'];
    imageProfile = json['image_profile'];
    // ignore: void_checks
    rememberToken = json['remember_token'];
    status = json['status'];
    type = json['type'];
    createdAt = json['created_at'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['phone'] = phone;
    data['email'] = email;
    data['provider'] = provider;
    data['social_token'] = socialToken;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['image_profile'] = imageProfile;
    data['remember_token'] = rememberToken;
    data['status'] = status;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['access_token'] = accessToken;
    return data;
  }
}
