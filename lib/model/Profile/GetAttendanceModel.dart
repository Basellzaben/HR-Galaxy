class GetAttendanceModel {
  List<GetAttendance>? list;

  GetAttendanceModel({this.list});

  GetAttendanceModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <GetAttendance>[];
      json.forEach((v) {
        list!.add(new GetAttendance.fromJson(v));
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

class GetAttendance {
  String? decription;
  String? attDate;
  String? sTime;
  String? eTime;
  String? notes;
  String? totalAttTimeDesc;
  String? late_Time;
  String? early_Time;
  String? realDiffInMinDesc;
  String? dayofweek1;

  GetAttendance(
      {this.decription,
        this.attDate,
        this.sTime,
        this.eTime,
        this.notes,
        this.totalAttTimeDesc,
        this.late_Time,
        this.realDiffInMinDesc,
        this.dayofweek1
      });

  GetAttendance.fromJson(Map<String, dynamic> json) {
    decription = json['decription'];
    attDate = json['att_Date'];
    sTime = json['s_Time'];
    eTime = json['e_Time'];
    notes = json['notes'];
    totalAttTimeDesc = json['totalAttTimeDesc'];
    late_Time = json['late_Time'];
    early_Time = json['early_Time'];
    realDiffInMinDesc = json['realDiffInMinDesc'];
    dayofweek1 = json['dayofweek1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['decription'] = this.decription;
    data['att_Date'] = this.attDate;
    data['s_Time'] = this.sTime;
    data['e_Time'] = this.eTime;
    data['notes'] = this.notes;
    data['totalAttTimeDesc'] = this.totalAttTimeDesc;
    data['late_Time'] = this.late_Time;
    data['early_Time'] = this.early_Time;
    data['realDiffInMinDesc'] = this.realDiffInMinDesc;
    data['dayofweek1'] = this.dayofweek1;
    return data;
  }
}
