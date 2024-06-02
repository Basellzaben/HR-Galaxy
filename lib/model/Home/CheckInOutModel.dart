class CheckInOutModel {
  List<CheckInOut>? list;

  CheckInOutModel({this.list});

  CheckInOutModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <CheckInOut>[];
      json.forEach((v) {
        list!.add(new CheckInOut.fromJson(v));
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
class CheckInOut {
  int? msgID;
  String? msgEN;
  String? msg;

  CheckInOut({this.msgID, this.msgEN, this.msg});

  CheckInOut.fromJson(Map<String, dynamic> json) {
    msgID = json['msgID'];
    msgEN = json['msgEN'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgID'] = this.msgID;
    data['msgEN'] = this.msgEN;
    data['msg'] = this.msg;
    return data;
  }
}
