class VacationsTypeModel {
  List<VacationsType>? list;

  VacationsTypeModel({this.list});

  VacationsTypeModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <VacationsType>[];
      json.forEach((v) {
        list!.add(new VacationsType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class VacationsType {
  int? type;
  String? arabicDescription;
  String? englishDescription;

  VacationsType({this.type, this.arabicDescription, this.englishDescription});

  VacationsType.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    arabicDescription = json['arabic_Description'];
    englishDescription = json['english_Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['arabic_Description'] = this.arabicDescription;
    data['english_Description'] = this.englishDescription;
    return data;
  }
}
