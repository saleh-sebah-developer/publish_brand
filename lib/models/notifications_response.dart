class NotificationsResponse {
  bool status;
  int code;
  String message;
  Notifications notifications;

  NotificationsResponse(
      {this.status, this.code, this.message, this.notifications});

  NotificationsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    notifications = json['notifications'] != null
        ? Notifications.fromJson(json['notifications'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (notifications != null) {
      data['notifications'] = notifications.toJson();
    }
    return data;
  }
}

class Notifications {
  int currentPage;
  List<Notificat> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  Null nextPageUrl;
  String path;
  int perPage;
  Null prevPageUrl;
  int to;
  int total;

  Notifications(
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

  Notifications.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Notificat>[];
      json['data'].forEach((v) {
        data.add(Notificat.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
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

class Notificat {
  int id;
  int fromDashboard;
  Null randomKey;
  int userId;
  String tag;
  int tagId;
  String message;
  String title;
  String createdAt;
  Null order;

  Notificat(
      {this.id,
        this.fromDashboard,
        this.randomKey,
        this.userId,
        this.tag,
        this.tagId,
        this.message,
        this.title,
        this.createdAt,
        this.order});

  Notificat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromDashboard = json['from_dashboard'];
    randomKey = json['random_key'];
    userId = json['user_id'];
    tag = json['tag'];
    tagId = json['tag_id'];
    message = json['message'];
    title = json['title'];
    createdAt = json['created_at'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_dashboard'] = fromDashboard;
    data['random_key'] = randomKey;
    data['user_id'] = userId;
    data['tag'] = tag;
    data['tag_id'] = tagId;
    data['message'] = message;
    data['title'] = title;
    data['created_at'] = createdAt;
    data['order'] = order;
    return data;
  }
}
