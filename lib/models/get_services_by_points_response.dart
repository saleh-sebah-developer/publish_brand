
import 'categories_response.dart';
import 'get_services_by_category_response.dart';

class GetServicesByPointsResponse {
  bool status;
  int code;
  String message;
  List<ServicesPoint> services;

  GetServicesByPointsResponse(
      {this.status, this.code, this.message, this.services});

  GetServicesByPointsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['services'] != null) {
      services = <ServicesPoint>[];
      json['services'].forEach((v) {
        services.add( ServicesPoint.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (services != null) {
      data['services'] = services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicesPoint {
  int id;
  int categoryId;
  int price;
  int points_count;
  String type;
  String estimatedTime;
  String image;
  String status;
  String createdAt;
  List<Photos> photos;
  String title;
  String details;
  Categories category;

  ServicesPoint(
      {this.id,
        this.categoryId,
        this.price,
        this.points_count,
        this.estimatedTime,
        this.image,
        this.status,
        this.createdAt,
        this.photos,
        this.title,
        this.details,
        this.category});

  ServicesPoint.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    price = json['price'];
    points_count = json['points_count'];
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
    category =
    json['category'] != null ? Categories.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['price'] = price;
    data['points_count'] = points_count;
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
