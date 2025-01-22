// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/Profile/GetCalenderModel.dart';
import 'package:mvvm/model/Profile/GetNotifiModel.dart';
import 'package:mvvm/model/Profile/GetSalaryModel.dart';
import 'package:mvvm/model/Profile/GetTimeLine.dart';
import 'package:http/http.dart' as http;

import 'package:mvvm/res/app_url.dart';

import '../../model/Profile/GetAttendanceMapModel.dart';
import '../../model/Profile/GetAttendanceModel.dart';
import '../../model/Profile/GetBalanceModel.dart';
import '../../model/Profile/LineDataModel.dart';
import '../../model/Profile/ProfileDataModel.dart';
import '../../model/Profile/SalaryslipHdrModel.dart';
import '../../model/Profile/SalaryslipModel.dart';

class ProfileRespository {

  BaseApiServices _apiServices = NetworkApiService() ;

  Future<ProfileDataModel> fetchGetProfileData(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetProfileData();
      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = ProfileDataModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      rethrow ;
    }
  }

  Future<GetCalenderModel> fetchGetCalenderData(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetCalenderData();
      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = GetCalenderModel.fromJson(response);

    }catch(e){
      print ("response2$e");
      rethrow ;
    }
  }
  Future<GetTimeLineModel> fetchGetTimeLine(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetTimeLine();
      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = GetTimeLineModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      rethrow ;
    }
  }
  Future<GetSalaryModel> fetchGetSalary(int empNo )async{

    try{
      // print(data.toString());
      // String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetSalary();
      url = url + "/$empNo";
            Uri apiUrl = Uri.parse(url);

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      // If the response is successful (status code 200), parse the JSON data
      dynamic responseData = jsonDecode(response.body);
      return GetSalaryModel.fromJson(responseData);
    } else {
      // If the response is not successful, throw an exception or handle the error
      throw Exception('Failed to load salary data');
    }
    }catch(e){
      print ("response2"+e.toString());
      rethrow ;
    }
  }
  Future<GetBalanceModel> fetchGetBalanceData(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetBalanceData();
      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = GetBalanceModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      rethrow ;
    }
  }
  Future<LineDataModel> fetchGetTimeData(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetTimeData();
      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = LineDataModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      rethrow ;
    }
  }
  Future<SalaryslipHdrModel> fetchSalaryslipHdr(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetHdeSalaryslip();
      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = SalaryslipHdrModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      rethrow ;
    }
  }
  Future<SalaryslipModel> fetchSalaryslip_setSalaryslip_Plugins(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetSalaryslip();

      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = SalaryslipModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      rethrow ;
    }
  }
  Future<SalaryslipModel> fetchSalaryslip_setSalaryslip_bonuses(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetSalaryslip();

      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = SalaryslipModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      rethrow ;
    }
  }
  Future<SalaryslipModel> fetchSalaryslip_setSalaryslip_Discount(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetSalaryslip();

      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = SalaryslipModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      rethrow ;
    }
  }
  Future<SalaryslipModel> fetchSalaryslip_setSalaryslip_deductions(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetSalaryslip();

      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = SalaryslipModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      rethrow ;
    }
  }
  Future<GetAttendanceModel> GetAttendancenew(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetAttendance();

      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = GetAttendanceModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      rethrow ;
    }
  }
//-----
  Future<GetAttendanceMapModel> GetAttendancenewMap(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      String url = await AppUrl.GetAttendanceMap();

      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = GetAttendanceMapModel.fromJson(response);

    }catch(e){
      print ("response2MAP"+e.toString());
      rethrow ;
    }
  }

  //----

  Future<GetNotifiModel> GetNotifidata(dynamic data )async{

    try{
      print(data.toString());
      String json = jsonEncode(data);
      print(json.toString());
      /*dynamic response =[
        {
          "Date": "2023/08/24",
          "Name": "حضور وانصراف الموظفين : تأخر الموظف ماجدة    مصطفى احمد صالح ",
          "NameEn": "Attendance and departure of employees: The employee, Magda Mustafa Ahmed Saleh, was late ",
          "Type": 1
        }
      ];*/
      String url = await AppUrl.GetNotiData();

      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = GetNotifiModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      rethrow ;
    }
  }

  Future<GetNotifiModel> GetNotifidataSend(dynamic data )async{

    try{
      print("12");
      String json = jsonEncode(data);
      print(json.toString());
      /*dynamic response =[
        {
          "Date": "2023/08/24",
          "Name": "حضور وانصراف الموظفين : تأخر الموظف ماجدة    مصطفى احمد صالح ",
          "NameEn": "Attendance and departure of employees: The employee, Magda Mustafa Ahmed Saleh, was late ",
          "Type": 1
        }
      ];*/
      String url = await AppUrl.GetNotiData();

      dynamic response = await _apiServices.getPostApiResponse1(url,json);

      return response = GetNotifiModel.fromJson(response);

    }catch(e){
      print ("response2"+e.toString());
      rethrow ;
    }
  }

}

