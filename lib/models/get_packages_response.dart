class GetPackagesResponse {
  bool status;
  int code;
  String message;
  List<Packages> packages;

  GetPackagesResponse({this.status, this.code, this.message, this.packages});

  GetPackagesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages.add(Packages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (packages != null) {
      data['packages'] = packages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Packages {
  int id;
  int price;
  String image;
  String file;
  num monthsCount;
  String status;
  String createdAt;
  String title;
  List<PackagesProperties> packagesProperties;

  Packages(
      {this.id,
        this.price,
        this.image,
        this.file,
        this.monthsCount,
        this.status,
        this.createdAt,
        this.title,
        this.packagesProperties});

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    file = json['file'];
    monthsCount = json['months_count'];
    status = json['status'];
    createdAt = json['created_at'];
    title = json['title'];
    if (json['packages_properties'] != null) {
      packagesProperties = <PackagesProperties>[];
      json['packages_properties'].forEach((v) {
        packagesProperties.add(PackagesProperties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['image'] = image;
    data['file'] = file;
    data['months_count'] = monthsCount;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['title'] = title;
    if (packagesProperties != null) {
      data['packages_properties'] =
          packagesProperties.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackagesProperties {
  int id;
  int packageId;
  String status;
  String createdAt;
  String title;

  PackagesProperties(
      {this.id, this.packageId, this.status, this.createdAt, this.title});

  PackagesProperties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['package_id'];
    status = json['status'];
    createdAt = json['created_at'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['package_id'] = packageId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['title'] = title;
    return data;
  }
}
