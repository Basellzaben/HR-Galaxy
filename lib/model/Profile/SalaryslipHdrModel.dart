class SalaryslipHdrModel {
  List<SalaryslipHdr>? list;

  SalaryslipHdrModel({this.list});

  SalaryslipHdrModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <SalaryslipHdr>[];
      json.forEach((v) {
        list!.add(new SalaryslipHdr.fromJson(v));
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


class SalaryslipHdr {
  String? basic;
  String? add;
  String? sup;
  String? tot;

  SalaryslipHdr({this.basic, this.add, this.sup, this.tot});

  SalaryslipHdr.fromJson(Map<String, dynamic> json) {
    basic = json['basic'];
    add = json['add'];
    sup = json['sup'];
    tot = json['tot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['basic'] = this.basic;
    data['add'] = this.add;
    data['sup'] = this.sup;
    data['tot'] = this.tot;
    return data;
  }
}
