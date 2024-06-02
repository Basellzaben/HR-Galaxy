class UserModel {
  String? Password;
  String? Username;

  UserModel({this.Password,this.Username});

  UserModel.fromJson(Map<String, dynamic> json) {
    Password = json['Password'];
    Username = json['Username'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Password'] = this.Password;
    data['Username'] = this.Username;

    return data;
  }
}

