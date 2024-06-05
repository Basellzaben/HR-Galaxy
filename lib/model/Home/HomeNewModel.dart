class HomeNewModel {
  List<HomeNModel>? list;

  HomeNewModel({this.list});

  HomeNewModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <HomeNModel>[];
      json.forEach((v) {
        list!.add(new HomeNModel.fromJson(v));
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
class HomeNModel {
  String? arabicName;
  String? englishName;
  String? countMyRequest;
  String? countTask;
  String? empBalance;
  String? letastAct;
  String? tTime;
  String? fTime;
  String? ss;
  String? sS1;
  String? sS2;
  String? countWar;
  String? empSumLeave;
  String? empBalanceSick;
  String? imagePath;
  int? sex;

  HomeNModel(
      {this.arabicName,
        this.englishName,
        this.countMyRequest,
        this.countTask,
        this.empBalance,
        this.letastAct,
        this.tTime,
        this.fTime,
        this.ss,
        this.sS1,
        this.sS2,
        this.countWar,
        this.empSumLeave,
        this.empBalanceSick,
        this.imagePath,
        this.sex
      });

  HomeNModel.fromJson(Map<String, dynamic> json) {
    arabicName = json['arabic_Name'];
    englishName = json['english_Name'];
    countMyRequest = json['count_MyRequest'];
    countTask = json['count_Task'];
    empBalance = json['empBalance'];
    letastAct = json['letastAct'];
    tTime = json['tTime'];
    fTime = json['fTime'];
    ss = json['ss'];
    sS1 = json['sS1'];
    sS2 = json['sS2'];
    countWar = json['countWar'];
    empSumLeave = json['empSumLeave'];
    empBalanceSick = json['empBalanceSick'];
    imagePath = json['imagePath'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arabic_Name'] = this.arabicName;
    data['english_Name'] = this.englishName;
    data['count_MyRequest'] = this.countMyRequest;
    data['count_Task'] = this.countTask;
    data['empBalance'] = this.empBalance;
    data['letastAct'] = this.letastAct;
    data['tTime'] = this.tTime;
    data['fTime'] = this.fTime;
    data['ss'] = this.ss;
    data['sS1'] = this.sS1;
    data['sS2'] = this.sS2;
    data['countWar'] = this.countWar;
    data['empSumLeave'] = this.empSumLeave;
    data['empBalanceSick'] = this.empBalanceSick;
    data['imagePath'] = this.imagePath;
    data['sex'] = this.sex;
    return data;
  }
}