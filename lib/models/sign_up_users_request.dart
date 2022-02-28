class SignUpUsersRequest {
  String name;
  String email;
  String password;
  String confirm_password;
  String mobile;
  String phone;
  String type;

  SignUpUsersRequest(
      {this.name,
      this.email,
      this.password,
      this.confirm_password,
      this.mobile,
      this.phone,
      this.type});

  toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'confirm_password': confirm_password,
      'mobile': mobile,
      'phone': phone,
      'type': type
    };
  }
}
