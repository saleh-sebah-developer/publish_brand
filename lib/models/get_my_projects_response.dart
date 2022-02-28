import 'get_services_by_category_response.dart';
import 'get_services_details_response.dart';
import 'login_for_users_response.dart';

class GetMyProjectsResponse {
  bool status;
  int code;
  String message;
  MyProjects myProjects;

  GetMyProjectsResponse(
      {this.status, this.code, this.message, this.myProjects});

  GetMyProjectsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    myProjects = json['myProjects'] != null
        ? MyProjects.fromJson(json['myProjects'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (myProjects != null) {
      data['myProjects'] = myProjects.toJson();
    }
    return data;
  }
}

class MyProjects {
  int currentPage;
  List<Data> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  MyProjects(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  MyProjects.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int id;
  String type;
  int userId;
  int serviceId;
  String title;
  String details;
  int paymentMethodId;
  int price;
  int couponId;
  int couponPercent;
  int couponAmount;
  int finalPrice;
  int rate;
  String cardNumber;
  String expiredDate;
  String validationNumber;
  String nameCardholder;
  String status;
  String createdAt;
  User user;
  Service service;
  PaymentMethod paymentMethod;

  Data(
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
      this.paymentMethod});

  Data.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
    paymentMethod = json['payment_method'] != null
        ? PaymentMethod.fromJson(json['payment_method'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    if (service != null) {
      data['service'] = service.toJson();
    }
    if (paymentMethod != null) {
      data['payment_method'] = paymentMethod.toJson();
    }
    return data;
  }
}

class PaymentMethod {
  int id;
  String image;
  String status;
  String createdAt;
  String name;

  PaymentMethod({this.id, this.image, this.status, this.createdAt, this.name});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['name'] = name;
    return data;
  }
}
