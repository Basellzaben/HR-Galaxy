// ignore_for_file: file_names, avoid_print

class GetTimeLineModel {
  List<GetTimeLine>? list;

  GetTimeLineModel({this.list});

  GetTimeLineModel.fromJson(List<dynamic> json) {
    print ("response6$json");
    if (json.isNotEmpty) {
      list = <GetTimeLine>[];
      for (var v in json) {
        list!.add(GetTimeLine.fromJson(v));
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



class GetTimeLine {
  int? rowID;
  String? descrip;
  String? curdates;

  GetTimeLine({this.rowID, this.descrip, this.curdates,});

 GetTimeLine.fromJson(Map<String, dynamic> json) {
    rowID = json['RowID'];
    descrip = json['descrip'];
    curdates = json['curdates'];
  }

Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RowID'] = rowID;
    data['descrip'] = descrip;
    data['curdates'] = curdates;
    return data;
  }
}
