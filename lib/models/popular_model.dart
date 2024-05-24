class PopularModel {
  int? id;
  String? name;
  int? gender;
  String? image;
  String? profession;
  List<KnownFor>? works;

  PopularModel({this.id, this.name, this.gender, this.image,this.works,this.profession});

  PopularModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    image = json['profile_path'];
    profession = json['known_for_department'];
    works = (json['known_for']).map<KnownFor>((work) => KnownFor.fromJson(work)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    data['profile_path'] = image;
    data['known_for_department'] = profession;
    data['known_for'] = works;
    return data;
  }
}

class KnownFor {
  int? id;
  String? title;
  String? mediaType;
  String? workImage;

  KnownFor({this.id, this.title, this.mediaType, this.workImage});

  KnownFor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    mediaType = json['media_type'];
    workImage = json['poster_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['media_type'] = mediaType;
    data['poster_path'] = workImage;
    return data;
  }
}