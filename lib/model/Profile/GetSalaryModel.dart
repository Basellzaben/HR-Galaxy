// ignore_for_file: file_names, avoid_print

class GetSalaryModel {
  List<GetSalary>? list;

  GetSalaryModel({this.list});

  GetSalaryModel.fromJson(List<dynamic> json) {
    print ("response6$json");
    if (json.isNotEmpty) {
      list = <GetSalary>[];
      for (var v in json) {
        list!.add(GetSalary.fromJson(v));
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



class GetSalary {
  String? subjectID;
  String? recCount;

  GetSalary({this.subjectID, this.recCount});

 GetSalary.fromJson(Map<String, dynamic> json) {
    subjectID = json['subjectID'];
    recCount = json['recCount'];
   
  }

Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subjectID'] = subjectID;
    data['recCount'] = recCount;
    
    return data;
  }
}
