import 'dart:convert';

import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/Vacations/AllEmployeeModel.dart';
import 'package:mvvm/model/Vacations/VacationsTypeModel.dart';
import 'package:mvvm/model/Vacations/Vacatios_Data.dart';
import 'package:mvvm/res/app_url.dart';

import '../../model/Home/CheckInOutModel.dart';
import '../../model/Vacations/GetApprovalHModel.dart';

class VacationsRespository {

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
  Future<VacatiosDataModel> fetchVacationsData(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
            String url = await AppUrl.GetVacatiosData();

      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = VacatiosDataModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      throw e ;
    }
  }
  Future<GetApprovalHModel> fetchGetApprovalHiostry(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
            String url = await AppUrl.GetApprovalH();

      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = GetApprovalHModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      throw e ;
    }
  }
  Future<AllEmployeeModel> fetchAllEmpList( )async{

    try{
      String url = await AppUrl.GETAllEmployees();

      dynamic response = await _apiServices.getGetApiResponse(url);
      print ("response2"+AllEmployeeModel.fromJson(response).toString());
      return response = AllEmployeeModel.fromJson(response);

    }catch(e){
      throw e ;
    }
  }

  Future<CheckInOutModel> fetchStatesV( )async{

    try{
/*      Map data = {
        "msgID": -1,
        "msgEN": "All",
        "msg": "الجميع",

      }*/
      dynamic data =[{   "msgID": -1, "msgEN": "All", "msg": "الجميع",},{   "msgID": 1, "msgEN": "finished", "msg": "منتهية",},{   "msgID": 2, "msgEN": "Not finished", "msg": "غير منتهية",}];

      return data = CheckInOutModel.fromJson(data);

    }catch(e){
      throw e ;
    }
  }

  Future<CheckInOutModel> GetCheckInOut(dynamic data )async{

    try{
      String json = jsonEncode(data);
      print(json);
            String url = await AppUrl.SaveVacatiosData();

      dynamic response = await _apiServices.getPostApiResponse1(url,json);
      return response = CheckInOutModel.fromJson(response);

    }catch(e){
      throw e ;
    }
  }
  Future<CheckInOutModel> setapproval(dynamic data )async{

    try{
      String json = jsonEncode(data);
      print(json);
            String url = await AppUrl.setApprovaldata();

      dynamic response = await _apiServices.getPostApiResponse1(url,json);
      return response = CheckInOutModel.fromJson(response);

    }catch(e){
      throw e ;
    }
  }


}

