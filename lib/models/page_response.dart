class PageResponse {
  bool status;
  int code;
  String message;
  Page page;

  PageResponse({this.status, this.code, this.message, this.page});

  PageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    page = json['page'] != null ? Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (page != null) {
      data['page'] = page.toJson();
    }
    return data;
  }
}

class Page {
  int id;
  String image;
  int views;
  String title;
  String slug;
  String description;
  String keyWords;

  Page(
      {this.id,
        this.image,
        this.views,
        this.title,
        this.slug,
        this.description,
        this.keyWords});

  Page.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    views = json['views'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    keyWords = json['key_words'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['views'] = views;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['key_words'] = keyWords;
    return data;
  }
}
