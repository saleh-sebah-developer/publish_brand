class UploadChatImgResponse {
  bool status;
  int code;
  String message;
  String file;
  String mime;

  UploadChatImgResponse(
      {this.status, this.code, this.message, this.file, this.mime});

  UploadChatImgResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    file = json['file'];
    mime = json['mime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    data['file'] = this.file;
    data['mime'] = this.mime;
    return data;
  }
}
