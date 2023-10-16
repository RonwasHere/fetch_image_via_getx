class PhotoModel {
  String? id;
  String? createdAt;
  String? color;
  Map<String, dynamic>? urls;

  PhotoModel({this.id, this.createdAt, this.color, this.urls});

  PhotoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    //createdAt = json['createdAt]; ==> before i type like this and get error 
    color = json['color'];
    urls = json['urls'];
  }
}
