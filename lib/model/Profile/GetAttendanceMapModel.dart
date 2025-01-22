class GetAttendanceMapModel {
  List<GetAttendanceM>? list;

  GetAttendanceMapModel({this.list});

  GetAttendanceMapModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <GetAttendanceM>[];
      json.forEach((v) {
        list!.add(new GetAttendanceM.fromJson(v));
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

class GetAttendanceM {
  String? decription;
  String? dayName;
  String? transDate;

  GetAttendanceM(
      {this.decription,
        this.dayName,
        this.transDate
      });

  GetAttendanceM.fromJson(Map<String, dynamic> json) {
    decription = json['decription'];
    dayName = json['dayName'];
    transDate = json['transDate'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['decription'] = this.decription;
    data['dayName'] = this.dayName;
    data['transDate'] = this.transDate;

    return data;
  }
}
