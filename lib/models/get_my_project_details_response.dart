import 'package:publish_brand/models/login_for_users_response.dart';

import 'get_services_by_category_response.dart';
import 'get_services_details_response.dart';

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
        json['project'] != null ? Project.fromJson(json['project']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  var employeeId;
  int userId;
  int serviceId;
  int categoryId;
  Null title;
  String details;
  var paymentMethodId;
  int quantity;
  int price;
  int couponId;
  int couponPercent;
  int couponAmount;
  int finalPrice;
  int rate;
  var cardNumber;
  var expiredDate;
  var validationNumber;
  var nameCardholder;
  String status;
  String createdAt;
  AdminChat adminChat;
  CategoryChat categoryChat;
  User user;
  var employee;
  Service service;
  var paymentMethod;

  Project(
      {this.id,
      this.type,
      this.employeeId,
      this.userId,
      this.serviceId,
      this.categoryId,
      this.title,
      this.details,
      this.paymentMethodId,
      this.quantity,
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
      this.adminChat,
      this.categoryChat,
      this.user,
      this.employee,
      this.service,
      this.paymentMethod});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    employeeId = json['employee_id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    categoryId = json['category_id'];
    title = json['title'];
    details = json['details'];
    paymentMethodId = json['payment_method_id'];
    quantity = json['quantity'];
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
    adminChat = json['admin_chat'] != null
        ? new AdminChat.fromJson(json['admin_chat'])
        : null;
    categoryChat = json['category_chat'] != null
        ? new CategoryChat.fromJson(json['category_chat'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    employee = json['employee'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    paymentMethod = json['payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['employee_id'] = this.employeeId;
    data['user_id'] = this.userId;
    data['service_id'] = this.serviceId;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['details'] = this.details;
    data['payment_method_id'] = this.paymentMethodId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['coupon_id'] = this.couponId;
    data['coupon_percent'] = this.couponPercent;
    data['coupon_amount'] = this.couponAmount;
    data['final_price'] = this.finalPrice;
    data['rate'] = this.rate;
    data['card_number'] = this.cardNumber;
    data['expired_date'] = this.expiredDate;
    data['validation_number'] = this.validationNumber;
    data['name_cardholder'] = this.nameCardholder;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    if (this.adminChat != null) {
      data['admin_chat'] = this.adminChat.toJson();
    }
    if (this.categoryChat != null) {
      data['category_chat'] = this.categoryChat.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['employee'] = this.employee;
    if (this.service != null) {
      data['service'] = this.service.toJson();
    }
    data['payment_method'] = this.paymentMethod;
    return data;
  }
}

// class AdminChat {
//   int id;
//   int orderId;
//   int user1;
//   int user2;
//   num categoryId;
//   int delete;
//   int freez;
//   String lastSeen;
//   String createdAt;
//   String lastMessage;
//   String totalUnread;
//   User user;
//   Category category;
//   List<num> messages;
//
//   AdminChat(
//       {this.id,
//         this.orderId,
//         this.user1,
//         this.user2,
//         this.categoryId,
//         this.delete,
//         this.freez,
//         this.lastSeen,
//         this.createdAt,
//         this.lastMessage,
//         this.totalUnread,
//         this.user,
//         this.category,
//         this.messages});
//
//   AdminChat.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     orderId = json['order_id'];
//     user1 = json['user1'];
//     user2 = json['user2'];
//     categoryId = json['category_id'];
//     delete = json['delete'];
//     freez = json['freez'];
//     lastSeen = json['last_seen'];
//     createdAt = json['created_at'];
//     lastMessage = json['last_message'];
//     totalUnread = json['total_unread'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     category = json['category'];
//     // if (json['messages'] != null) {
//     //   messages = <Null>[];
//     //   json['messages'].forEach((v) {
//     //     messages.add(new Null.fromJson(v));
//     //   });
//     // }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['order_id'] = this.orderId;
//     data['user1'] = this.user1;
//     data['user2'] = this.user2;
//     data['category_id'] = this.categoryId;
//     data['delete'] = this.delete;
//     data['freez'] = this.freez;
//     data['last_seen'] = this.lastSeen;
//     data['created_at'] = this.createdAt;
//     data['last_message'] = this.lastMessage;
//     data['total_unread'] = this.totalUnread;
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     data['category'] = this.category;
//     // if (this.messages != null) {
//     //   data['messages'] = this.messages.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
// }
class AdminChat {
  int id;
  int orderId;
  int user1;
  int user2;
  int categoryId;
  Null empChat;
  int delete;
  int freez;
  String lastSeen;
  String createdAt;
  String lastMessage;
  String totalUnread;
  User user;
  Null category;
  List<Null> messages;

  AdminChat(
      {this.id,
      this.orderId,
      this.user1,
      this.user2,
      this.categoryId,
      this.empChat,
      this.delete,
      this.freez,
      this.lastSeen,
      this.createdAt,
      this.lastMessage,
      this.totalUnread,
      this.user,
      this.category,
      this.messages});

  AdminChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    user1 = json['user1'];
    user2 = json['user2'];
    categoryId = json['category_id'];
    empChat = json['emp_chat'];
    delete = json['delete'];
    freez = json['freez'];
    lastSeen = json['last_seen'];
    createdAt = json['created_at'];
    lastMessage = json['last_message'];
    totalUnread = json['total_unread'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    // category = json['category'];
    // if (json['messages'] != null) {
    //   messages = <Null>[];
    //   json['messages'].forEach((v) {
    //     messages.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['user1'] = this.user1;
    data['user2'] = this.user2;
    data['category_id'] = this.categoryId;
    data['emp_chat'] = this.empChat;
    data['delete'] = this.delete;
    data['freez'] = this.freez;
    data['last_seen'] = this.lastSeen;
    data['created_at'] = this.createdAt;
    data['last_message'] = this.lastMessage;
    data['total_unread'] = this.totalUnread;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    // data['category'] = this.category;
    // if (this.messages != null) {
    //   data['messages'] = this.messages.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

// class CategoryChat {
//   int id;
//   int orderId;
//   int user1;
//   var user2;
//   int categoryId;
//   int delete;
//   int freez;
//   var lastSeen;
//   String createdAt;
//   var lastMessage;
//   var totalUnread;
//   User user;
//   Category category;
//   List<Null> messages;
//
//   CategoryChat(
//       {this.id,
//       this.orderId,
//       this.user1,
//       this.user2,
//       this.categoryId,
//       this.delete,
//       this.freez,
//       this.lastSeen,
//       this.createdAt,
//       this.lastMessage,
//       this.totalUnread,
//       this.user,
//       this.category,
//       this.messages});
//
//   CategoryChat.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     orderId = json['order_id'];
//     user1 = json['user1'];
//     user2 = json['user2'];
//     categoryId = json['category_id'];
//     delete = json['delete'];
//     freez = json['freez'];
//     lastSeen = json['last_seen'];
//     createdAt = json['created_at'];
//     lastMessage = json['last_message'];
//     totalUnread = json['total_unread'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     category = json['category'] != null
//         ? new Category.fromJson(json['category'])
//         : null;
//     // if (json['messages'] != null) {
//     //   messages = <Null>[];
//     //   json['messages'].forEach((v) {
//     //     messages!.add(new Null.fromJson(v));
//     //   });
//     // }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['order_id'] = this.orderId;
//     data['user1'] = this.user1;
//     data['user2'] = this.user2;
//     data['category_id'] = this.categoryId;
//     data['delete'] = this.delete;
//     data['freez'] = this.freez;
//     data['last_seen'] = this.lastSeen;
//     data['created_at'] = this.createdAt;
//     data['last_message'] = this.lastMessage;
//     data['total_unread'] = this.totalUnread;
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     if (this.category != null) {
//       data['category'] = this.category.toJson();
//     }
//     // if (this.messages != null) {
//     //   data['messages'] = this.messages.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
// }
class CategoryChat {
  int id;
  int orderId;
  int user1;
  Null user2;
  int categoryId;
  Null empChat;
  int delete;
  int freez;
  String lastSeen;
  String createdAt;
  String lastMessage;
  String totalUnread;
  User user;
  Category category;
  List<Null> messages;

  CategoryChat(
      {this.id,
        this.orderId,
        this.user1,
        this.user2,
        this.categoryId,
        this.empChat,
        this.delete,
        this.freez,
        this.lastSeen,
        this.createdAt,
        this.lastMessage,
        this.totalUnread,
        this.user,
        this.category,
        this.messages});

  CategoryChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    user1 = json['user1'];
    user2 = json['user2'];
    categoryId = json['category_id'];
    empChat = json['emp_chat'];
    delete = json['delete'];
    freez = json['freez'];
    lastSeen = json['last_seen'];
    createdAt = json['created_at'];
    lastMessage = json['last_message'];
    totalUnread = json['total_unread'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    // if (json['messages'] != null) {
    //   messages = <Null>[];
    //   json['messages'].forEach((v) {
    //     messages.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['user1'] = this.user1;
    data['user2'] = this.user2;
    data['category_id'] = this.categoryId;
    data['emp_chat'] = this.empChat;
    data['delete'] = this.delete;
    data['freez'] = this.freez;
    data['last_seen'] = this.lastSeen;
    data['created_at'] = this.createdAt;
    data['last_message'] = this.lastMessage;
    data['total_unread'] = this.totalUnread;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    // if (this.messages != null) {
    //   data['messages'] = this.messages.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

