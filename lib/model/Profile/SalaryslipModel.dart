class SalaryslipModel {
  List<Salaryslip>? list;

  SalaryslipModel({this.list});

  SalaryslipModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <Salaryslip>[];
      json.forEach((v) {
        list!.add(new Salaryslip.fromJson(v));
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


class Salaryslip {
  String? description;
  String? eDescription;
  String? amt;

  Salaryslip({this.description, this.eDescription, this.amt});

  Salaryslip.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    eDescription = json['e_Description'];
    amt = json['amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['e_Description'] = this.eDescription;
    data['amt'] = this.amt;
    return data;
  }
}