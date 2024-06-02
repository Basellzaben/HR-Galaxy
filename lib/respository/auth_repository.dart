

import 'dart:convert';

import 'package:http/http.dart';
import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/res/app_url.dart';

import '../model/Home/CheckInOutModel.dart';

class AuthRepository  {

  BaseApiServices _apiServices = NetworkApiService() ;


  Future<dynamic> loginApi(dynamic data )async{

    try{
     var data1 =jsonEncode(data);
     print(data1);
      String url = await AppUrl.getLoginEndPoint();
      dynamic response = await _apiServices.getPostApiResponse1(url, data1);
      return response ;

    }catch(e){
      throw e ;
    }
  }

  Future<CheckInOutModel> ChangeLogin(dynamic data )async{

    try{
      var data1 =jsonEncode(data);
      print(data1);
            String url = await AppUrl.ChangeLogin();

      dynamic response = await _apiServices.getPostApiResponse1(url, data1);
      print(response.toString());
      return response =CheckInOutModel.fromJson(response);


    }catch(e){
      throw e ;
    }
  }

  Future<dynamic> signUpApi(dynamic data )async{

    try{
      String url = await AppUrl.registerApiEndPoint();

      dynamic response = await _apiServices.getPostApiResponse(url, data);
      return response ;


    }catch(e){
      throw e ;
    }
  }

}