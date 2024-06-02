

import 'package:flutter/cupertino.dart';
import 'package:mvvm/model/Profile/GetCalenderModel.dart';
import 'package:mvvm/model/Profile/GetNotifiModel.dart';
import 'package:mvvm/model/Profile/GetSalaryModel.dart';
import 'package:mvvm/model/Profile/GetTimeLine.dart';
import 'package:mvvm/model/Profile/LineDataModel.dart';
import 'package:mvvm/model/Profile/SalaryslipModel.dart';

import '../../data/response/api_response.dart';
import '../../model/Profile/GetAttendanceModel.dart';
import '../../model/Profile/GetBalanceModel.dart';
import '../../model/Profile/ProfileDataModel.dart';
import '../../model/Profile/SalaryslipHdrModel.dart';
import '../../respository/Profile/Profile_repository.dart';

class ProfileViewModel with ChangeNotifier {

  final _myRepo = ProfileRespository();
  bool _loading = false ;
  bool get loading => _loading ;


  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }
  ApiResponse<ProfileDataModel> ProfileData = ApiResponse.loading();
  ApiResponse<GetBalanceModel> GetBalance = ApiResponse.loading();
  ApiResponse<LineDataModel> LineData = ApiResponse.loading();
 ApiResponse<SalaryslipHdrModel> SalaryslipHdr = ApiResponse.loading();
  ApiResponse<SalaryslipModel> Salaryslip_deductions = ApiResponse.loading();
  ApiResponse<SalaryslipModel> Salaryslip_Plugins = ApiResponse.loading();
  ApiResponse<SalaryslipModel> Salaryslip_bonuses = ApiResponse.loading();
  ApiResponse<SalaryslipModel> Salaryslip_Discount = ApiResponse.loading();
  ApiResponse<GetAttendanceModel> Attendance = ApiResponse.loading();
  ApiResponse<GetNotifiModel> Noto = ApiResponse.loading();
  ApiResponse<GetNotifiModel> Notosend = ApiResponse.loading();
  ApiResponse<GetCalenderModel> CalenderData = ApiResponse.loading();
  ApiResponse<GetTimeLineModel> TimeLineData = ApiResponse.loading();
    ApiResponse<GetSalaryModel> SalaryData = ApiResponse.loading();

  /*ApiResponse<CheckInOutModel> setApproval = ApiResponse.loading();*/

  setProfileData(ApiResponse<ProfileDataModel> response){
    ProfileData = response ;
    notifyListeners();
  }
  setCalenderData(ApiResponse<GetCalenderModel> response){
    CalenderData = response ;
    notifyListeners();
  }
  setTimeLineData(ApiResponse<GetTimeLineModel> response){
    TimeLineData = response ;
    notifyListeners();
  }
  setSalaryData(ApiResponse<GetSalaryModel> response){
    SalaryData = response ;
    notifyListeners();
  }
  GetNotifidataa(ApiResponse<GetNotifiModel> response){
    Noto = response ;
    notifyListeners();
  }
  GetNotifidataSend(ApiResponse<GetNotifiModel> response){
    Notosend = response ;
    notifyListeners();
  }
  GetAttendance(ApiResponse<GetAttendanceModel> response){
    Attendance = response ;
    notifyListeners();
  }  setLineData(ApiResponse<LineDataModel> response){
    LineData = response ;
    notifyListeners();
  }
  setGetBalance(ApiResponse<GetBalanceModel> response){
    GetBalance = response ;
    notifyListeners();
  }
  setSalaryslipHdr(ApiResponse<SalaryslipHdrModel> response){
    SalaryslipHdr = response ;
    notifyListeners();
  }

  setSalaryslip_deductions(ApiResponse<SalaryslipModel> response){
    Salaryslip_deductions = response ;
    notifyListeners();
  }

  setSalaryslip_Plugins(ApiResponse<SalaryslipModel> response){
    Salaryslip_Plugins = response ;
    notifyListeners();
  }
  setSalaryslip_bonuses(ApiResponse<SalaryslipModel> response){
    Salaryslip_bonuses = response ;
    notifyListeners();
  }
  setSalaryslip_Discount(ApiResponse<SalaryslipModel> response){
    Salaryslip_Discount = response ;
    notifyListeners();
  }




  Future<void> fetchGetProfileData (dynamic data , BuildContext context) async {

    setProfileData(ApiResponse.loading());

    _myRepo.fetchGetProfileData(data).then((value){
      print("response7");
      setProfileData(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setProfileData(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchGetBalanceData (dynamic data , BuildContext context) async {

    setGetBalance(ApiResponse.loading());

    _myRepo.fetchGetBalanceData(data).then((value){
      print("response7");
      setGetBalance(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setGetBalance(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchGetTimeData (dynamic data , BuildContext context) async {

    setLineData(ApiResponse.loading());

    _myRepo.fetchGetTimeData(data).then((value){
      print("response7");
      setLineData(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setLineData(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchSalaryslip_setSalaryslip_deductions (dynamic data , BuildContext context) async {

    setSalaryslip_deductions(ApiResponse.loading());

    _myRepo.fetchSalaryslip_setSalaryslip_deductions(data).then((value){
      print("response7");
      setSalaryslip_deductions(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setSalaryslip_deductions(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchSalaryslip_setSalaryslip_Plugins (dynamic data , BuildContext context) async {

    setSalaryslip_Plugins(ApiResponse.loading());

    _myRepo.fetchSalaryslip_setSalaryslip_Plugins(data).then((value){
      print("response7");
      setSalaryslip_Plugins(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setSalaryslip_Plugins(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchSalaryslip_setSalaryslip_bonuses (dynamic data , BuildContext context) async {

    setSalaryslip_bonuses(ApiResponse.loading());

    _myRepo.fetchSalaryslip_setSalaryslip_bonuses(data).then((value){
      print("response7");
      setSalaryslip_bonuses(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setSalaryslip_bonuses(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchSalaryslip_setSalaryslip_Discount (dynamic data , BuildContext context) async {

    setSalaryslip_Discount(ApiResponse.loading());

    _myRepo.fetchSalaryslip_setSalaryslip_Discount(data).then((value){
      print("response7");
      setSalaryslip_Discount(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setSalaryslip_Discount(ApiResponse.error(error.toString()));

    });
  }
  Future<void> GetAttendancenew (dynamic data , BuildContext context) async {

    GetAttendance(ApiResponse.loading());

    _myRepo.GetAttendancenew(data).then((value){
      print("response7");
      GetAttendance(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      GetAttendance(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchSalaryslipHdr (dynamic data , BuildContext context) async {

    setSalaryslipHdr(ApiResponse.loading());

    _myRepo.fetchSalaryslipHdr(data).then((value){
      print("response7");
      setSalaryslipHdr(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setSalaryslipHdr(ApiResponse.error(error.toString()));

    });
  }

  Future<void> GetNotifidata (dynamic data , BuildContext context) async {

    GetNotifidataa(ApiResponse.loading());

    _myRepo.GetNotifidata(data).then((value){
      print("response7");
      GetNotifidataa(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      GetNotifidataa(ApiResponse.error(error.toString()));

    });
  }

  Future<void> GetNotifidataSend1 (dynamic data , BuildContext context) async {
    print("11");
    GetNotifidataSend(ApiResponse.loading());

    _myRepo.GetNotifidataSend(data).then((value){
      print("response7");
      GetNotifidataSend(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      GetNotifidataSend(ApiResponse.error(error.toString()));

    });
  }
  
  Future<void> fetchGetCalenderData (dynamic data , BuildContext context) async {

    setCalenderData(ApiResponse.loading());

   await _myRepo.fetchGetCalenderData(data).then((value){
      print("response7");
      setCalenderData(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setCalenderData(ApiResponse.error(error.toString()));

    });
  }
  
  Future<void> fetchGetTimeLine (dynamic data , BuildContext context) async {

    setTimeLineData(ApiResponse.loading());

    _myRepo.fetchGetTimeLine(data).then((value){
      print("response7");
      setTimeLineData(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setTimeLineData(ApiResponse.error(error.toString()));

    });
  }
  
  Future<void> fetchGetSalary (int EmpNo , BuildContext context) async {

    setSalaryData(ApiResponse.loading());

    _myRepo.fetchGetSalary(EmpNo).then((value){
      print("response7");
      setSalaryData(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setSalaryData(ApiResponse.error(error.toString()));

    });
  }

}