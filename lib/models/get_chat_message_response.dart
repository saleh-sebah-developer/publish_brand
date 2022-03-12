class getChatMessageResponse {
  bool status;
  int code;
  String message;
  List<Messages> messages;

  getChatMessageResponse({this.status, this.code, this.message, this.messages});

  getChatMessageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  int id;
  int chatId;
  int senderId;
  String message;
  int readAt;
  int type;
  String createdAt;

  Messages(
      {this.id,
        this.chatId,
        this.senderId,
        this.message,
        this.readAt,
        this.type,
        this.createdAt});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chat_id'];
    senderId = json['sender_id'];
    message = json['message'];
    readAt = json['read_at'];
    type = json['type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat_id'] = this.chatId;
    data['sender_id'] = this.senderId;
    data['message'] = this.message;
    data['read_at'] = this.readAt;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    return data;
  }
}
