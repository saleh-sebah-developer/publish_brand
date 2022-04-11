class SignUpUsersRequest {
  String name;
  String email;
  String password;
  String confirm_password;
  String mobile;
  String phone;
  String type;
  String fcm_token;
  String device_type;

  SignUpUsersRequest(
      {this.name,
      this.email,
      this.password,
      this.confirm_password,
      this.mobile,
      this.phone,
      this.type,
      this.fcm_token,
      this.device_type});

  toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'confirm_password': confirm_password,
      'mobile': mobile,
      'phone': phone,
      'type': type,
      'fcm_token': fcm_token,
      'device_type': device_type
    };
  }
}
