import 'package:publish_brand/models/get_services_by_category_response.dart';

class GetServicesDetailsResponse {
  bool status;
  int code;
  String message;
  Service service;

  GetServicesDetailsResponse(
      {this.status, this.code, this.message, this.service});

  GetServicesDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    service =
    json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (service != null) {
      data['service'] = service.toJson();
    }
    return data;
  }
}

class Service {
  int id;
  int categoryId;
  int price;
  num offerPrice;
  num pointsCount;
  num activePrice;
  String type;
  String estimatedTime;
  String image;
  String status;
  String createdAt;
  List<Photos> photos;
  String title;
  String details;
  Category category;

  Service(
      {this.id,
        this.categoryId,
        this.price,
        this.offerPrice,
        this.pointsCount,
        this.activePrice,
        this.type,
        this.estimatedTime,
        this.image,
        this.status,
        this.createdAt,
        this.photos,
        this.title,
        this.details,
        this.category});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    price = json['price'];
    offerPrice = json['offer_price'];
    pointsCount = json['points_count'];
    activePrice = json['active_price'];
    type = json['type'];
    estimatedTime = json['estimated_time'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos.add(Photos.fromJson(v));
      });
    }
    title = json['title'];
    details = json['details'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['price'] = price;
    data['offer_price'] = offerPrice;
    data['points_count'] = pointsCount;
    data['active_price'] = activePrice;
    data['type'] = type;
    data['estimated_time'] = estimatedTime;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    if (photos != null) {
      data['photos'] = photos.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    data['details'] = details;
    if (category != null) {
      data['category'] = category.toJson();
    }
    return data;
  }
}

class Photos {
  int id;
  String file;
  int attachmentableId;
  String attachmentableType;
  String createdAt;

  Photos(
      {this.id,
        this.file,
        this.attachmentableId,
        this.attachmentableType,
        this.createdAt});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    attachmentableId = json['attachmentable_id'];
    attachmentableType = json['attachmentable_type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['file'] = file;
    data['attachmentable_id'] = attachmentableId;
    data['attachmentable_type'] = attachmentableType;
    data['created_at'] = createdAt;
    return data;
  }
}

