class ContactMsgResponse {
  bool status;
  int code;
  String message;
  ContactMsg contactMsg;

  ContactMsgResponse({this.status, this.code, this.message, this.contactMsg});

  ContactMsgResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    contactMsg = json['contact_msg'] != null
        ? ContactMsg.fromJson(json['contact_msg'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (contactMsg != null) {
      data['contact_msg'] = contactMsg.toJson();
    }
    return data;
  }
}

class ContactMsg {
  int userId;
  String name;
  String phone;
  String message;
  int read;
  String createdAt;
  int id;

  ContactMsg(
      {this.userId,
        this.name,
        this.phone,
        this.message,
        this.read,
        this.createdAt,
        this.id});

  ContactMsg.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    phone = json['phone'];
    message = json['message'];
    read = json['read'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['phone'] = phone;
    data['message'] = message;
    data['read'] = read;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
