class TaskModel {
  List<Task>? list;

  TaskModel({this.list});

  TaskModel.fromJson(List<dynamic> json) {

    if (json.length != 0) {
      list = <Task>[];
      json.forEach((v) {
        list!.add(new Task.fromJson(v));
      });
      print ("response6:"+list!.length.toString());
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
class Task {
  String? workFlowID;
  String? wfRequestID;
  String? reqEmp;
  String? reqEmpEN;
  String? empNo;
  String? fromEmpName;
  String? fromEmpNameEN;
  String? fromEmpNo;
  String? wfAction;
  String? wdate;
  String? wfReType2;
  String? requestDescNew;
  String? requestDescEnNew;
  String? leaveStartDate;
  String? leaveEndDate;
  String? leaveDate;
  String? vacStartDate;
  String? vacEndDate;
  String? lNotes;
  String? vNotes;
  String? image1;
  String? imageName;
  String? ext;

  Task(
      {this.workFlowID,
        this.wfRequestID,
        this.reqEmp,
        this.reqEmpEN,
        this.empNo,
        this.fromEmpName,
        this.fromEmpNameEN,
        this.fromEmpNo,
        this.wfAction,
        this.wdate,
        this.wfReType2,
        this.requestDescNew,
        this.requestDescEnNew,
        this.leaveStartDate,
        this.leaveEndDate,
        this.leaveDate,
        this.vacStartDate,
        this.vacEndDate,
        this.lNotes,
        this.vNotes,
        this.image1,
        this.imageName,
        this.ext});

  Task.fromJson(Map<String, dynamic> json) {
    workFlowID = json['workFlowID'];
    wfRequestID = json['wfRequestID'];
    reqEmp = json['reqEmp'];
    reqEmpEN = json['reqEmpEN'];
    empNo = json['emp_no'];
    fromEmpName = json['fromEmp_Name'];
    fromEmpNameEN = json['fromEmp_NameEN'];
    fromEmpNo = json['fromEmp_no'];
    wfAction = json['wfAction'];
    wdate = json['wdate'];
    wfReType2 = json['wfReType2'];
    requestDescNew = json['requestDescNew'];
    requestDescEnNew = json['requestDescEnNew'];
    leaveStartDate = json['leaveStartDate'];
    leaveEndDate = json['leaveEndDate'];
    leaveDate = json['leaveDate'];
    vacStartDate = json['vacStartDate'];
    vacEndDate = json['vacEndDate'];
    lNotes = json['lNotes'];
    vNotes = json['vNotes'];
    image1 = json['image1'];
    imageName = json['imageName'];
    ext = json['ext'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workFlowID'] = this.workFlowID;
    data['wfRequestID'] = this.wfRequestID;
    data['reqEmp'] = this.reqEmp;
    data['reqEmpEN'] = this.reqEmpEN;
    data['emp_no'] = this.empNo;
    data['fromEmp_Name'] = this.fromEmpName;
    data['fromEmp_NameEN'] = this.fromEmpNameEN;
    data['fromEmp_no'] = this.fromEmpNo;
    data['wfAction'] = this.wfAction;
    data['wdate'] = this.wdate;
    data['wfReType2'] = this.wfReType2;
    data['requestDescNew'] = this.requestDescNew;
    data['requestDescEnNew'] = this.requestDescEnNew;
    data['leaveStartDate'] = this.leaveStartDate;
    data['leaveEndDate'] = this.leaveEndDate;
    data['leaveDate'] = this.leaveDate;
    data['vacStartDate'] = this.vacStartDate;
    data['vacEndDate'] = this.vacEndDate;
    data['lNotes'] = this.lNotes;
    data['vNotes'] = this.vNotes;
    data['image1'] = this.image1;
    data['imageName'] = this.imageName;
    data['ext'] = this.ext;
    return data;
  }
}
