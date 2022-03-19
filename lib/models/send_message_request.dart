class SendMessageRequest {
  String project_id;
  String message;
  String image;
  String file;
  String type;
  String target;

  SendMessageRequest({
    this.project_id,
    this.message,
    this.image,
    this.file,
    this.type,
    this.target,
  });

  toJson() {
    return {
      'project_id': project_id,
      'message': message,
      'image': image,
      'file': file,
      'type': type,
      'target': target
    };
  }
}
