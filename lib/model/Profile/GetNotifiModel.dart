class GetNotifiModel {
  List<GetNotifi>? list;

  GetNotifiModel({this.list});

  GetNotifiModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <GetNotifi>[];
      json.forEach((v) {
        list!.add(new GetNotifi.fromJson(v));
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
class GetNotifi {
  String? dayDate;
  String? fieldVal;
  String? fieldValEn;
  String? notiDisplayID;

  GetNotifi({this.dayDate, this.fieldVal, this.fieldValEn, this.notiDisplayID});

  GetNotifi.fromJson(Map<String, dynamic> json) {
    dayDate = json['dayDate'];
    fieldVal = json['fieldVal'];
    fieldValEn = json['fieldValEn'];
    notiDisplayID = json['notiDisplayID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayDate'] = this.dayDate;
    data['fieldVal'] = this.fieldVal;
    data['fieldValEn'] = this.fieldValEn;
    data['notiDisplayID'] = this.notiDisplayID;
    return data;
  }
}