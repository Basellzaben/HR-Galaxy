// ignore_for_file: file_names, avoid_print

class GetCalenderModel {
  List<GetCalender>? list;

  GetCalenderModel({this.list});

  GetCalenderModel.fromJson(List<dynamic> json) {
    print ("response6$json");
    if (json.isNotEmpty) {
      list = <GetCalender>[];
      for (var v in json) {
        list!.add(GetCalender.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class GetCalender {
  int? empNo;
  String? startingDate;
  String? reason;
  String? type;
  String? colorType;

  GetCalender({this.empNo, this.startingDate, this.reason, this.type,this.colorType});

 GetCalender.fromJson(Map<String, dynamic> json) {
    empNo = json['Emp_no'];
    startingDate = json['starting_date'];
    reason = json['reason'];
    type = json['type'];
    colorType = json['colorType'];
  }

Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Emp_no'] = empNo;
    data['starting_date'] = startingDate;
    data['reason'] = reason;
    data['type'] = type;
    data['colorType'] = colorType;
    return data;
  }
}
