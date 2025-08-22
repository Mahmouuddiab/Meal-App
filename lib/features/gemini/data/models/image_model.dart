class ImageModel {
  ImageModel({
    this.results,
    this.offset,
    this.number,
    this.totalResults,
  });

  ImageModel.fromJson(dynamic json) {
    if (json['results'] != null) {
      // Corrected initialization and type casting
      results = List<Results>.from(
          json['results'].map((v) => Results.fromJson(v)));
    }
    offset = json['offset'];
    number = json['number'];
    totalResults = json['totalResults'];
  }
  List<Results>? results;
  int? offset;
  int? number;
  int? totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    map['number'] = number;
    map['totalResults'] = totalResults;
    return map;
  }
}

// No changes needed in the Results class
class Results {
  Results({
    this.id,
    this.title,
    this.image,
    this.imageType,
  });

  Results.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    imageType = json['imageType'];
  }
  int? id;
  String? title;
  String? image;
  String? imageType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image'] = image;
    map['imageType'] = imageType;
    return map;
  }
}