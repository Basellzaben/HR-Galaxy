class LineDataModel {
  List<LineData>? list;

  LineDataModel({this.list});

  LineDataModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <LineData>[];
      json.forEach((v) {
        list!.add(new LineData.fromJson(v));
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

class LineData {
  int? subjectID;
  String? subjectDesc;
  String? recCount;
  String? perRecCountNo;

  LineData(
      {this.subjectID, this.subjectDesc, this.recCount, this.perRecCountNo});

  LineData.fromJson(Map<String, dynamic> json) {
    subjectID = json['subjectID'];
    subjectDesc = json['subjectDesc'];
    recCount = json['recCount'];
    perRecCountNo = json['perRecCountNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subjectID'] = this.subjectID;
    data['subjectDesc'] = this.subjectDesc;
    data['recCount'] = this.recCount;
    data['perRecCountNo'] = this.perRecCountNo;
    return data;
  }
}

