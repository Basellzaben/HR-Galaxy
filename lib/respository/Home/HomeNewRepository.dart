import 'dart:convert';

import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/Home/GetImageModel.dart';
import 'package:mvvm/model/Home/HomeNewModel.dart';
import 'package:mvvm/res/app_url.dart';

import '../../model/Home/CheckInOutModel.dart';

class HomeNewRepository{

BaseApiServices _apiServices = NetworkApiService() ;

Future<HomeNewModel> GetHomeData(dynamic data )async{

try{
  String json = jsonEncode(data);
  print(json);
  String url = await AppUrl.GetHomeData();
dynamic response = await _apiServices.getPostApiResponse1(url,json);
return response = HomeNewModel.fromJson(response);

}catch(e){
throw e ;
}
}
Future<CheckInOutModel> GetCheckInOut(dynamic data )async{

  try{
    String json = jsonEncode(data);
    String url = await AppUrl.CheckINOUT();
    dynamic response = await _apiServices.getPostApiResponse1(url,json);
    return response = CheckInOutModel.fromJson(response);

  }catch(e){
    throw e ;
  }
}
Future<CheckInOutModel> set_deleteReq(dynamic data )async{

  try{
    String json = jsonEncode(data);
    print(json);
    String url = await AppUrl.deleteRequst();
    dynamic response = await _apiServices.getPostApiResponse1(url,json);
    return response = CheckInOutModel.fromJson(response);

  }catch(e){
    throw e ;
  }
}
Future<GetImageModel> GetImageRep(dynamic data )async{

  try{
    String json = jsonEncode(data);
    print(json);
    String url = await AppUrl.GetImageModel();
    dynamic response = await _apiServices.getPostApiResponse1(url,json);
    return response = GetImageModel.fromJson(response);

  }catch(e){
    throw e ;
  }
}


}
