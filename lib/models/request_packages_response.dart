class RequestPackagesResponse {
  bool status;
  int code;
  String message;
  OrderPackages order;

  RequestPackagesResponse({this.status, this.code, this.message, this.order});

  RequestPackagesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    order = json['order'] != null ?  OrderPackages.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (order != null) {
      data['order'] = order.toJson();
    }
    return data;
  }
}

class OrderPackages {
  int userId;
  String packageId;
  String details;
  String contractExpiredDate;
  String paymentMethodId;
  num finalPrice;
  String cardNumber;
  String expiredDate;
  String validationNumber;
  String nameCardholder;
  String contractFile;
  String createdAt;
  int id;

  OrderPackages(
      {this.userId,
        this.packageId,
        this.details,
        this.contractExpiredDate,
        this.paymentMethodId,
        this.finalPrice,
        this.cardNumber,
        this.expiredDate,
        this.validationNumber,
        this.nameCardholder,
        this.contractFile,
        this.createdAt,
        this.id});

  OrderPackages.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    packageId = json['package_id'];
    details = json['details'];
    contractExpiredDate = json['contract_expired_date'];
    paymentMethodId = json['payment_method_id'];
    finalPrice = json['final_price'];
    cardNumber = json['card_number'];
    expiredDate = json['expired_date'];
    validationNumber = json['validation_number'];
    nameCardholder = json['name_cardholder'];
    contractFile = json['contract_file'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['user_id'] = userId;
    data['package_id'] = packageId;
    data['details'] = details;
    data['contract_expired_date'] = contractExpiredDate;
    data['payment_method_id'] = paymentMethodId;
    data['final_price'] = finalPrice;
    data['card_number'] = cardNumber;
    data['expired_date'] = expiredDate;
    data['validation_number'] = validationNumber;
    data['name_cardholder'] = nameCardholder;
    data['contract_file'] = contractFile;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
