import 'dart:convert';

import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/MyRequest/MyRequestModel.dart';
import 'package:mvvm/model/MyRequest/TaskModel.dart';
import 'package:mvvm/model/Vacations/AllEmployeeModel.dart';
import 'package:mvvm/model/Vacations/VacationsTypeModel.dart';
import 'package:mvvm/model/Vacations/Vacatios_Data.dart';
import 'package:mvvm/res/app_url.dart';

class MyRequestRespository {

  BaseApiServices _apiServices = NetworkApiService() ;

  Future<VacationsTypeModel> fetchVacationsTypeList(dynamic data )async{

    try{
      String url = await AppUrl.GetVacatiosType();
      dynamic response = await _apiServices.getPostApiResponse(url,data);
      print ("response2"+VacationsTypeModel.fromJson(response).toString());
      return response = VacationsTypeModel.fromJson(response);

    }catch(e){
      throw e ;
    }
  }
  Future<VacationsTypeModel> fetchLeaveTypeList(dynamic data )async{

    try{

      String url = await AppUrl.GetLeaveType();
      dynamic response = await _apiServices.getPostApiResponse(url,data);

      return response = VacationsTypeModel.fromJson(response);

    }catch(e){
      throw e ;
    }
  }
  Future<MyRequestModel> fetchMyRequestData(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      print(AppUrl.GetMyRequestData);
      String url = await AppUrl.GetMyRequestData();
      
      dynamic response = await _apiServices.getPostApiResponse1(url,json);
      print ("response2"+response.toString());
      return response = MyRequestModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      throw e ;
    }
  }
 Future<MyRequestModel> fetchMyRequestDatadetails(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetMyRequestData();
      dynamic response = await _apiServices.getPostApiResponse1(url,json);
      print ("response2"+response.toString());
      return response = MyRequestModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      throw e ;
    }
  }
  Future<TaskModel> fetchTaskData(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetTaskData();
      dynamic response = await _apiServices.getPostApiResponse1(url,json);
      print ("response2"+response.toString());
      return response = TaskModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      throw e ;
    }
  }
 Future<TaskModel> fetchTaskDatadetails(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetTaskData();
      dynamic response = await _apiServices.getPostApiResponse1(url,json);
      print ("response2"+response.toString());
      return response = TaskModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      throw e ;
    }
  }
  Future<VacationsTypeModel> fetchAllRequst(dynamic data )async{

    try{
String ip=await  AppUrl.GetMyRequestType();
      print ("response2"+data.toString());
      dynamic response = await _apiServices.getPostApiResponse(ip,data);
      print ("response2"+response.toString());
      return response = VacationsTypeModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      throw e ;
    }
  }


}

