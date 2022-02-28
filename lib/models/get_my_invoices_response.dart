class GetMyInvoicesResponse {
  bool status;
  int code;
  String message;
  MyInvoices myInvoices;

  GetMyInvoicesResponse({this.status, this.code, this.message, this.myInvoices});

  GetMyInvoicesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    myInvoices = json['my_invoices'] != null
        ? MyInvoices.fromJson(json['my_invoices'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (myInvoices != null) {
      data['my_invoices'] = myInvoices.toJson();
    }
    return data;
  }
}

class MyInvoices {
  int currentPage;
  List<Invoice> data;
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

  MyInvoices(
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

  MyInvoices.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Invoice>[];
      json['data'].forEach((v) {
        data.add(Invoice.fromJson(v));
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

class Invoice {
  int id;
  int userId;
  String file;
  String createdAt;

  Invoice({this.id, this.userId, this.file, this.createdAt});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    file = json['file'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['file'] = file;
    data['created_at'] = createdAt;
    return data;
  }
}
