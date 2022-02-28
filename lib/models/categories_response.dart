class CategoriesResponse {
  bool status;
  int code;
  String message;
  List<Categories> categories;

  CategoriesResponse({this.status, this.code, this.message, this.categories});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (categories != null) {
      data['categories'] = categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int id;
  String image;
  String status;
  String createdAt;
  int servicesCount;
  String name;

  Categories(
      {this.id,
        this.image,
        this.status,
        this.createdAt,
        this.servicesCount,
        this.name});

  Categories.fromJson(Map<String, dynamic> json) {
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
