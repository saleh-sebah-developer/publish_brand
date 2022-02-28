import 'package:publish_brand/models/home_response.dart';

class GetServicesByCategoryResponse {
  bool status;
  int code;
  String message;
  Category category;
  List<Services> services;

  GetServicesByCategoryResponse(
      {this.status, this.code, this.message, this.category, this.services});

  GetServicesByCategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services.add(Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (category != null) {
      data['category'] = category.toJson();
    }
    if (services != null) {
      data['services'] = services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int id;
  String image;
  String status;
  String createdAt;
  int servicesCount;
  String name;

  Category(
      {this.id,
        this.image,
        this.status,
        this.createdAt,
        this.servicesCount,
        this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    servicesCount = json['services_count'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['services_count'] = servicesCount;
    data['name'] = name;
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
