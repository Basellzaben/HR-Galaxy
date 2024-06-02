class ProfileDataModel {
  List<ProfileData>? list;

  ProfileDataModel({this.list});

  ProfileDataModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <ProfileData>[];
      json.forEach((v) {
        list!.add(new ProfileData.fromJson(v));
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


class ProfileData {
  int? managerNumber;
  String? employeeDisplayName;
  String? jobTitle;
  String? email;
  String? employeeSectionDescription;
  String? employeeDepartmentDescription;
  String? managerName;
  String? attStatus;
  String? yearsOfExp;

  ProfileData(
      {this.managerNumber,
        this.employeeDisplayName,
        this.jobTitle,
        this.email,
        this.employeeSectionDescription,
        this.employeeDepartmentDescription,
        this.managerName,
        this.attStatus,
        this.yearsOfExp});

  ProfileData.fromJson(Map<String, dynamic> json) {
    managerNumber = json['managerNumber'];
    employeeDisplayName = json['employeeDisplayName'];
    jobTitle = json['jobTitle'];
    email = json['email'];
    employeeSectionDescription = json['employeeSectionDescription'];
    employeeDepartmentDescription = json['employeeDepartmentDescription'];
    managerName = json['managerName'];
    attStatus = json['attStatus'];
    yearsOfExp = json['yearsOfExp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['managerNumber'] = this.managerNumber;
    data['employeeDisplayName'] = this.employeeDisplayName;
    data['jobTitle'] = this.jobTitle;
    data['email'] = this.email;
    data['employeeSectionDescription'] = this.employeeSectionDescription;
    data['employeeDepartmentDescription'] = this.employeeDepartmentDescription;
    data['managerName'] = this.managerName;
    data['attStatus'] = this.attStatus;
    data['yearsOfExp'] = this.yearsOfExp;
    return data;
  }
}
