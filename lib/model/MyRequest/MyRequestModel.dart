class MyRequestModel {
  List<MyRequest>? list;

  MyRequestModel({this.list});

  MyRequestModel.fromJson(List<dynamic> json) {

    if (json.length != 0) {
      list = <MyRequest>[];
      json.forEach((v) {
        list!.add(new MyRequest.fromJson(v));
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
class MyRequest {
  int? request;
  int? requestType;
  String? requestNameArabic;
  String? requestNameEn;
  String? requestDate;
  int? requestAction;
  int? requestNo;
  String? empArabic;
  String? empEn;
  String? leaveStartDate;
  String? leaveEndDate;
  String? vacStartDate;
  String? vacEndDate;
  String? leaveDate;
  String? lNotes;
  String? vNotes;
  String? mangerNotes;

  MyRequest(
      {this.request,
        this.requestType,
        this.requestNameArabic,
        this.requestNameEn,
        this.requestDate,
        this.requestAction,
        this.requestNo,
        this.empArabic,
        this.empEn,
        this.leaveStartDate,
        this.leaveEndDate,
        this.vacStartDate,
        this.vacEndDate,
        this.leaveDate,
        this.lNotes,
        this.vNotes,
        this.mangerNotes
      });

  MyRequest.fromJson(Map<String, dynamic> json) {
    request = json['request'];
    requestType = json['requestType'];
    requestNameArabic = json['requestName_Arabic'];
    requestNameEn = json['requestName_En'];
    requestDate = json['request_Date'];
    requestAction = json['requestAction'];
    requestNo = json['requestNo'];
    empArabic = json['empArabic'];
    empEn = json['empEn'];
    leaveStartDate = json['leaveStartDate'];
    leaveEndDate = json['leaveEndDate'];
    vacStartDate = json['vacStartDate'];
    vacEndDate = json['vacEndDate'];
    leaveDate = json['leaveDate'];
    lNotes = json['lNotes'];
    vNotes = json['vNotes'];
    mangerNotes = json['mangerNotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request'] = this.request;
    data['requestType'] = this.requestType;
    data['requestName_Arabic'] = this.requestNameArabic;
    data['requestName_En'] = this.requestNameEn;
    data['request_Date'] = this.requestDate;
    data['requestAction'] = this.requestAction;
    data['requestNo'] = this.requestNo;
    data['empArabic'] = this.empArabic;
    data['empEn'] = this.empEn;
    data['leaveStartDate'] = this.leaveStartDate;
    data['leaveEndDate'] = this.leaveEndDate;
    data['vacStartDate'] = this.vacStartDate;
    data['vacEndDate'] = this.vacEndDate;
    data['leaveDate'] = this.leaveDate;
    data['lNotes'] = this.lNotes;
    data['vNotes'] = this.leaveDate;
    data['mangerNotes'] = this.mangerNotes;
    return data;
  }
}
