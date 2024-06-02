class AllEmployeeModel {
  List<AllEmployee>? list;

  AllEmployeeModel({this.list});

  AllEmployeeModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <AllEmployee>[];
      json.forEach((v) {
        list!.add(new AllEmployee.fromJson(v));
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
class AllEmployee {
  String? employeeNo;
  String? arabicName;
  String? englishName;

  AllEmployee({this.employeeNo, this.arabicName, this.englishName});

  AllEmployee.fromJson(Map<String, dynamic> json) {
    employeeNo = json['employeeNo'];
    arabicName = json['arabic_Name'];
    englishName = json['english_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeNo'] = this.employeeNo;
    data['arabic_Name'] = this.arabicName;
    data['english_Name'] = this.englishName;
    return data;
  }
}
