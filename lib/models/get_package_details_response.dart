import 'get_packages_response.dart';

class GetPackageDetailsResponse {
  bool status;
  int code;
  String message;
  Package package;

  GetPackageDetailsResponse(
      {this.status, this.code, this.message, this.package});

  GetPackageDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    package =
    json['package'] != null ?  Package.fromJson(json['package']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (package != null) {
      data['package'] = package.toJson();
    }
    return data;
  }
}

class Package {
  int id;
  int price;
  String image;
  String status;
  String createdAt;
  String title;
  String details;
  List<PackagesProperties> packagesProperties;

  Package(
      {this.id,
        this.price,
        this.image,
        this.status,
        this.createdAt,
        this.title,
        this.details,
        this.packagesProperties});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    title = json['title'];
    details = json['details'];
    if (json['packages_properties'] != null) {
      packagesProperties = <PackagesProperties>[];
      json['packages_properties'].forEach((v) {
        packagesProperties.add( PackagesProperties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['title'] = title;
    data['details'] = details;
    if (packagesProperties != null) {
      data['packages_properties'] =
          packagesProperties.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

