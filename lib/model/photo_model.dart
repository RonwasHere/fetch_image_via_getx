class PhotoModel {
  String? id;
  String? createdAt;
  String? color;
  Map<String, dynamic>? urls;

  PhotoModel({this.id, this.createdAt, this.color, this.urls});

  PhotoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    color = json['color'];
    urls = json['urls'];
  }
}
