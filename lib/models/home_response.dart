import 'package:publish_brand/models/categories_response.dart';

class HomeResponse {
  bool status;
  int code;
  String message;
  List<Ads> ads;
  int notificationCount;
  List<Categories> categories;
  List<Services> services;

  HomeResponse(
      {this.status,
      this.code,
      this.message,
      this.ads,
      this.notificationCount,
      this.categories,
      this.services});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['ads'] != null) {
      ads = <Ads>[];
      json['ads'].forEach((v) {
        ads.add(Ads.fromJson(v));
      });
    }
    notificationCount = json['notificationCount'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(Categories.fromJson(v));
      });
    }
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
    if (ads != null) {
      data['ads'] = ads.map((v) => v.toJson()).toList();
    }
    data['notificationCount'] = notificationCount;
    if (categories != null) {
      data['categories'] = categories.map((v) => v.toJson()).toList();
    }
    if (services != null) {
      data['services'] = services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ads {
  int id;
  String image;
  String url;
  String status;
  String name;
  String details;

  Ads({this.id, this.image, this.url, this.status, this.name, this.details});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    url = json['url'];
    status = json['status'];
    name = json['name'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['url'] = url;
    data['status'] = status;
    data['name'] = name;
    data['details'] = details;
    return data;
  }
}

class Services {
  int id;
  int categoryId;
  num price;
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
  Categories category;

  Services(
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

  Services.fromJson(Map<String, dynamic> json) {
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
    category =
        json['category'] != null ? Categories.fromJson(json['category']) : null;
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
