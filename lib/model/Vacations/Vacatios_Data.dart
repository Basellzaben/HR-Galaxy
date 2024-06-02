class VacatiosDataModel {
  List<VacatiosData>? list;

  VacatiosDataModel({this.list});

  VacatiosDataModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <VacatiosData>[];
      json.forEach((v) {
        list!.add(new VacatiosData.fromJson(v));
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
class VacatiosData {
  int? numberPreviousVacations;
  int? dayDiff;
  double? balance;
  String? dateLastVacatios;
  int? neglectBalance;
  int? isBackUpEmp;
  int? isAddress;
  int? isDocmetion;

  VacatiosData(
      {this.numberPreviousVacations,
        this.dayDiff,
        this.balance,
        this.dateLastVacatios,
        this.neglectBalance,
        this.isBackUpEmp,
        this.isAddress,
        this.isDocmetion});

  VacatiosData.fromJson(Map<String, dynamic> json) {

    numberPreviousVacations = json['numberPreviousVacations'];
    dayDiff = json['dayDiff']==null?0.0:json['dayDiff'];
    balance = json['balance']==null?0.0:json['balance'];
    dateLastVacatios = json['dateLastVacatios'].toString()??"";
    neglectBalance = json['neglectBalance'];
    isBackUpEmp = json['isBackUpEmp'];
    isAddress = json['isAddress'];
    isDocmetion = json['isDocmetion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numberPreviousVacations'] = this.numberPreviousVacations;
    data['dayDiff'] = this.dayDiff==null?0.0:this.dayDiff;
    data['balance'] = this.balance==null?0.0:this.balance;
    data['dateLastVacatios'] = this.dateLastVacatios;
    data['neglectBalance'] = this.neglectBalance;
    data['isBackUpEmp'] = this.isBackUpEmp;
    data['isAddress'] = this.isAddress;
    data['isDocmetion'] = this.isDocmetion;
    return data;
  }
}
