import 'package:publish_brand/models/login_for_users_response.dart';

class GetMyProjectDetailsResponse {
  bool status;
  int code;
  String message;
  Project project;

  GetMyProjectDetailsResponse(
      {this.status, this.code, this.message, this.project});

  GetMyProjectDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    project =
    json['project'] != null ?  Project.fromJson(json['project']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (project != null) {
      data['project'] = project.toJson();
    }
    return data;
  }
}

class Project {
  int id;
  String type;
  int userId;
  int serviceId;
  String title;
  String details;
  var paymentMethodId;
  num price;
  var couponId;
  var couponPercent;
  var couponAmount;
  num finalPrice;
  int rate;
  var cardNumber;
  var expiredDate;
  var validationNumber;
  var nameCardholder;
  String status;
  String createdAt;
  User user;
  var service;
  var paymentMethod;
  Chat chat;

  Project(
      {this.id,
        this.type,
        this.userId,
        this.serviceId,
        this.title,
        this.details,
        this.paymentMethodId,
        this.price,
        this.couponId,
        this.couponPercent,
        this.couponAmount,
        this.finalPrice,
        this.rate,
        this.cardNumber,
        this.expiredDate,
        this.validationNumber,
        this.nameCardholder,
        this.status,
        this.createdAt,
        this.user,
        this.service,
        this.paymentMethod,
        this.chat});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    title = json['title'];
    details = json['details'];
    paymentMethodId = json['payment_method_id'];
    price = json['price'];
    couponId = json['coupon_id'];
    couponPercent = json['coupon_percent'];
    couponAmount = json['coupon_amount'];
    finalPrice = json['final_price'];
    rate = json['rate'];
    cardNumber = json['card_number'];
    expiredDate = json['expired_date'];
    validationNumber = json['validation_number'];
    nameCardholder = json['name_cardholder'];
    status = json['status'];
    createdAt = json['created_at'];
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
    service = json['service'];
    paymentMethod = json['payment_method'];
    chat = json['chat'] != null ?  Chat.fromJson(json['chat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['user_id'] = userId;
    data['service_id'] = serviceId;
    data['title'] = title;
    data['details'] = details;
    data['payment_method_id'] = paymentMethodId;
    data['price'] = price;
    data['coupon_id'] = couponId;
    data['coupon_percent'] = couponPercent;
    data['coupon_amount'] = couponAmount;
    data['final_price'] = finalPrice;
    data['rate'] = rate;
    data['card_number'] = cardNumber;
    data['expired_date'] = expiredDate;
    data['validation_number'] = validationNumber;
    data['name_cardholder'] = nameCardholder;
    data['status'] = status;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user.toJson();
    }
    data['service'] = service;
    data['payment_method'] = paymentMethod;
    if (chat != null) {
      data['chat'] = chat.toJson();
    }
    return data;
  }
}


class Chat {
  int id;
  int orderId;
  int user1;
  int user2;
  int delete;
  int freez;
  String lastSeen;
  String createdAt;
  String lastMessage;
  String totalUnread;
  User user;
  List<Null> messages;

  Chat(
      {this.id,
        this.orderId,
        this.user1,
        this.user2,
        this.delete,
        this.freez,
        this.lastSeen,
        this.createdAt,
        this.lastMessage,
        this.totalUnread,
        this.user,
        this.messages});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    user1 = json['user1'];
    user2 = json['user2'];
    delete = json['delete'];
    freez = json['freez'];
    lastSeen = json['last_seen'];
    createdAt = json['created_at'];
    lastMessage = json['last_message'];
    totalUnread = json['total_unread'];
    user = json['user'];
    /*
    if (json['messages'] != null) {
      messages = <Null>[];
      json['messages'].forEach((v) {
        messages.add( Null.fromJson(v));
      });
    }
    */
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['user1'] = user1;
    data['user2'] = user2;
    data['delete'] = delete;
    data['freez'] = freez;
    data['last_seen'] = lastSeen;
    data['created_at'] = createdAt;
    data['last_message'] = lastMessage;
    data['total_unread'] = totalUnread;
    data['user'] = user;
    /*
    if (messages != null) {
      data['messages'] = messages.map((v) => v.toJson()).toList();
    }
    */
    return data;
  }
}
