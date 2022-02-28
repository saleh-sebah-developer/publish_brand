class RequestSpecialServiceResponse {
  bool status;
  int code;
  String message;
  OrderSpecialService order;

  RequestSpecialServiceResponse({this.status, this.code, this.message, this.order});

  RequestSpecialServiceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    order = json['order'] != null ? OrderSpecialService.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (order != null) {
      data['order'] = order.toJson();
    }
    return data;
  }
}

class OrderSpecialService {
  int userId;
  String type;
  String title;
  String details;
  String createdAt;
  int id;

  OrderSpecialService(
      {this.userId,
        this.type,
        this.title,
        this.details,
        this.createdAt,
        this.id});

  OrderSpecialService.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    type = json['type'];
    title = json['title'];
    details = json['details'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['user_id'] = userId;
    data['type'] = type;
    data['title'] = title;
    data['details'] = details;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
