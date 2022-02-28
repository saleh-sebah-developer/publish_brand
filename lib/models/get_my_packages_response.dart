import 'get_package_details_response.dart';

class GetMyPackagesResponse {
  bool status;
  int code;
  String message;
  MyPackages myPackages;

  GetMyPackagesResponse(
      {this.status, this.code, this.message, this.myPackages});

  GetMyPackagesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    myPackages = json['my_packages'] != null
        ?  MyPackages.fromJson(json['my_packages'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (myPackages != null) {
      data['my_packages'] = myPackages.toJson();
    }
    return data;
  }
}

class MyPackages {
  int currentPage;
  List<ListPackage> data;
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

  MyPackages(
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

  MyPackages.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ListPackage>[];
      json['data'].forEach((v) {
        data.add( ListPackage.fromJson(v));
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
    final Map<String, dynamic> data =  <String, dynamic>{};
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

class ListPackage {
  int id;
  int userId;
  int packageId;
  String details;
  String contractExpiredDate;
  int paymentMethodId;
  String contractFile;
  String cardNumber;
  String expiredDate;
  String validationNumber;
  String nameCardholder;
  int finalPrice;
  String createdAt;
  Package package;

  ListPackage(
      {this.id,
        this.userId,
        this.packageId,
        this.details,
        this.contractExpiredDate,
        this.paymentMethodId,
        this.contractFile,
        this.cardNumber,
        this.expiredDate,
        this.validationNumber,
        this.nameCardholder,
        this.finalPrice,
        this.createdAt,
        this.package});

  ListPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    packageId = json['package_id'];
    details = json['details'];
    contractExpiredDate = json['contract_expired_date'];
    paymentMethodId = json['payment_method_id'];
    contractFile = json['contract_file'];
    cardNumber = json['card_number'];
    expiredDate = json['expired_date'];
    validationNumber = json['validation_number'];
    nameCardholder = json['name_cardholder'];
    finalPrice = json['final_price'];
    createdAt = json['created_at'];
    package =
    json['package'] != null ?  Package.fromJson(json['package']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['package_id'] = packageId;
    data['details'] = details;
    data['contract_expired_date'] = contractExpiredDate;
    data['payment_method_id'] = paymentMethodId;
    data['contract_file'] = contractFile;
    data['card_number'] = cardNumber;
    data['expired_date'] = expiredDate;
    data['validation_number'] = validationNumber;
    data['name_cardholder'] = nameCardholder;
    data['final_price'] = finalPrice;
    data['created_at'] = createdAt;
    if (package != null) {
      data['package'] = package.toJson();
    }
    return data;
  }
}
