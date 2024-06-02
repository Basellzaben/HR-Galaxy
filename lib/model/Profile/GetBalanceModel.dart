class GetBalanceModel {
  List<GetBalance>? list;

  GetBalanceModel({this.list});

  GetBalanceModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <GetBalance>[];
      json.forEach((v) {
        list!.add(new GetBalance.fromJson(v));
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



class GetBalance {
  int? vactType;
  String? vacDesc;
  String? vacDescEn;
  String? total;

  GetBalance({this.vactType, this.vacDesc, this.vacDescEn, this.total});

  GetBalance.fromJson(Map<String, dynamic> json) {
    vactType = json['vact_Type'];
    vacDesc = json['vacDesc'];
    vacDescEn = json['vacDescEn'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vact_Type'] = this.vactType;
    data['vacDesc'] = this.vacDesc;
    data['vacDescEn'] = this.vacDescEn;
    data['total'] = this.total;
    return data;
  }
}
