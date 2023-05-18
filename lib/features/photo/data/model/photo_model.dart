class PhotoModel {
  final String id;
  final String urlPhoto;

  PhotoModel({required this.id, required this.urlPhoto});
  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(id: json['id'], urlPhoto: json['urls']['regular']);
  }

  factory PhotoModel.fromLocalJson(Map<String, dynamic> json) {
    return PhotoModel(id: json['id'], urlPhoto: json['urlPhoto']);
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'urlPhoto': urlPhoto};
  }
}
