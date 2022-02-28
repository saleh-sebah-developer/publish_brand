class RequestServiceResponse {
  bool status;
  int code;
  String message;
  OrderService order;

  RequestServiceResponse({this.status, this.code, this.message, this.order});

  RequestServiceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    order = json['order'] != null ? OrderService.fromJson(json['order']) : null;
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

class OrderService {
  int userId;
  String serviceId;
  String details;
  String paymentMethodId;
  num price;
  int couponId;
  num couponPercent;
  String couponAmount;
  num finalPrice;
  String cardNumber;
  String expiredDate;
  String validationNumber;
  String nameCardholder;
  String createdAt;
  int id;

  OrderService(
      {this.userId,
        this.serviceId,
        this.details,
        this.paymentMethodId,
        this.price,
        this.couponId,
        this.couponPercent,
        this.couponAmount,
        this.finalPrice,
        this.cardNumber,
        this.expiredDate,
        this.validationNumber,
        this.nameCardholder,
        this.createdAt,
        this.id});

  OrderService.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    serviceId = json['service_id'];
    details = json['details'];
    paymentMethodId = json['payment_method_id'];
    price = json['price'];
    couponId = json['coupon_id'];
    couponPercent = json['coupon_percent'];
    couponAmount = json['coupon'];
    finalPrice = json['final_price'];
    cardNumber = json['card_number'];
    expiredDate = json['expired_date'];
    validationNumber = json['validation_number'];
    nameCardholder = json['name_cardholder'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['service_id'] = serviceId;
    data['details'] = details;
    data['payment_method_id'] = paymentMethodId;
    data['price'] = price;
    data['coupon_id'] = couponId;
    data['coupon_percent'] = couponPercent;
    data['coupon_amount'] = couponAmount;
    data['final_price'] = finalPrice;
    data['card_number'] = cardNumber;
    data['expired_date'] = expiredDate;
    data['validation_number'] = validationNumber;
    data['name_cardholder'] = nameCardholder;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
