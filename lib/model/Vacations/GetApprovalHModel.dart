
class GetApprovalHModel {
  List<GetApprovalH>? list;

  GetApprovalHModel({this.list});

  GetApprovalHModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <GetApprovalH>[];
      json.forEach((v) {
        list!.add(new GetApprovalH.fromJson(v));
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
class GetApprovalH {
  String? toEmpNo;
  int? actionNo;
  String? userFName;
  String? userLName;
  String? note;
  String? jobDesc;
  String? jobDescEN;
  String? wdate;

  GetApprovalH(
      {this.toEmpNo,
        this.actionNo,
        this.userFName,
        this.userLName,
        this.note,
        this.jobDesc,
        this.jobDescEN,
        this.wdate});

  GetApprovalH.fromJson(Map<String, dynamic> json) {
    toEmpNo = json['toEmp_no'];
    actionNo = json['actionNo'];
    userFName = json['user_FName'];
    userLName = json['user_LName'];
    note = json['note'];
    jobDesc = json['jobDesc'];
    jobDescEN = json['jobDescEN'];
    wdate = json['wdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toEmp_no'] = this.toEmpNo;
    data['actionNo'] = this.actionNo;
    data['user_FName'] = this.userFName;
    data['user_LName'] = this.userLName;
    data['note'] = this.note;
    data['jobDesc'] = this.jobDesc;
    data['jobDescEN'] = this.jobDescEN;
    data['wdate'] = this.wdate;
    return data;
  }
}
