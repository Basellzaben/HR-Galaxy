class GetImageModel {
  List<GetImage>? list;

  GetImageModel({this.list});

  GetImageModel.fromJson(List<dynamic> json) {
    print ("response6"+json.toString());
    if (json.length != 0) {
      list = <GetImage>[];
      json.forEach((v) {
        list!.add(new GetImage.fromJson(v));
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
class GetImage {

  String? imagePath;


  GetImage({ this.imagePath});

  GetImage.fromJson(Map<String, dynamic> json) {

    imagePath = json['imagePath'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['imagePath'] = this.imagePath;

    return data;
  }
}
