

import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/Home/CheckInOutModel.dart';
import 'package:mvvm/model/Vacations/AllEmployeeModel.dart';
import 'package:mvvm/model/Vacations/VacationsTypeModel.dart';
import 'package:mvvm/model/Vacations/Vacatios_Data.dart';

import 'package:mvvm/respository/Vacations/Vacations_Respository.dart';
import 'package:provider/provider.dart';

import '../../model/Vacations/GetApprovalHModel.dart';
import '../../model/Vacations/Vacatios_Data.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../services/LanguagePrvider.dart';


class Vacationsviewmodel with ChangeNotifier {

  final _myRepo = VacationsRespository();
  bool _loading = false ;
  bool get loading => _loading ;
  int  _VacationsShowType = -1 ;
  int get VacationsShowType => _VacationsShowType;
  setVacationsShowType(int VacationsShowType) {
    _VacationsShowType = VacationsShowType;
    notifyListeners();
  }
  int  Vstates = -1 ;
  int  INOUT = -1 ;
  String  INOUTName = "" ;
  int  INOUT1 = -1 ;
  String  INOUTName1 = "" ;
  String  VstatesName = "" ;
  int  _EmpShowNoalternative = 0 ;
  int get EmpShowNoalternative => _EmpShowNoalternative;
  String _EmpNamealternative="";
  String get EmpNamealternative => _EmpNamealternative;
  String _VacationsTypeName="";
  String get VacationsTypeName => _VacationsTypeName;
  String _Outdialog="";
  String get Outdialog => _Outdialog;
  setOutdialog(String Outdialog) {
    _Outdialog = Outdialog;
    notifyListeners();
  }
  String _Indialog="";
  String get Indialog => _Indialog;
  setIndialog(String Indialog) {
    _Indialog = Indialog;
    notifyListeners();
  }
  setVacationsTypeName(String VacationsTypeName) {
    _VacationsTypeName = VacationsTypeName;
    notifyListeners();
  }
  String Image_Path="";
  String _Imag_Name="";
  setImag_Name(String Imag_Name) {
    _Imag_Name = Imag_Name;
    notifyListeners();
  }
  String get Imag_Name => _Imag_Name;
  int chex=0;
  setVacations(int VacationsShowType, String VacationsTypeName) {
    _VacationsShowType = VacationsShowType;
    _VacationsTypeName = VacationsTypeName;


    notifyListeners();
  }
  setImage_Path(String Image_Path) {
    this.Image_Path = Image_Path;
    notifyListeners();
  }
  setchex(int chex) {
    this.chex = chex;
    notifyListeners();
  }

  setVacationstates(int Vstates, String VstatesName) {
    this.Vstates = Vstates;
    this.VstatesName = VstatesName;


    notifyListeners();
  }
  setINOUT(int INOUT, String INOUTName) {
    this.INOUT = INOUT;
    this.INOUTName = INOUTName;


    notifyListeners();
  }
  setINOUT1(int INOUT1, String INOUTName1) {
    this.INOUT1 = INOUT1;
    this.INOUTName1 = INOUTName1;


    notifyListeners();
  }
  setEmpalternative(int EmpShowNoalternative, String EmpNamealternative) {
    _EmpShowNoalternative = EmpShowNoalternative;
    _EmpNamealternative = EmpNamealternative;


    notifyListeners();
  }
  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }
  ApiResponse<VacationsTypeModel> VacationsType = ApiResponse.loading();
  ApiResponse<VacationsTypeModel> LeaveType = ApiResponse.loading();
  ApiResponse<VacatiosDataModel> VacatiosData = ApiResponse.loading();
  ApiResponse<AllEmployeeModel> AllEmployee = ApiResponse.loading();
  ApiResponse<CheckInOutModel> CheckINO = ApiResponse.loading();
  ApiResponse<CheckInOutModel> setApproval = ApiResponse.loading();
  ApiResponse<CheckInOutModel> setRequstStates = ApiResponse.loading();
  ApiResponse<GetApprovalHModel> GetApprovalH = ApiResponse.loading();

  setCheckINOUT(ApiResponse<CheckInOutModel> response){
    CheckINO = response ;
    notifyListeners();
  }
  setRequstStatess(ApiResponse<CheckInOutModel> response){
    setRequstStates = response ;
    notifyListeners();
  }
  setApprovals(ApiResponse<CheckInOutModel> response){
    setApproval = response ;
    notifyListeners();
  }

  setGetApprovalH(ApiResponse<GetApprovalHModel> response){
    GetApprovalH = response ;
    notifyListeners();
  }

  setVacationsType(ApiResponse<VacationsTypeModel> response){
    print("response7"+response.data.toString());
    VacationsType = response ;

    notifyListeners();
  }
  setLeaveType(ApiResponse<VacationsTypeModel> response){
    print("response7"+response.data.toString());
    LeaveType = response ;

    notifyListeners();
  }
  setVacationsData(ApiResponse<VacatiosDataModel> response){

    VacatiosData = response ;

    notifyListeners();
  }
  setAllEmployee(ApiResponse<AllEmployeeModel> response){
    print("response7"+response.data.toString());
    AllEmployee = response ;

    notifyListeners();
  }

  Future<void> fetchVacationsTypeList (dynamic data , BuildContext context) async {

    setVacationsType(ApiResponse.loading());

    _myRepo.fetchVacationsTypeList(data).then((value){
      print("response7");
      setVacationsType(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setVacationsType(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchLeaveTypeList (dynamic data , BuildContext context) async {

    setLeaveType(ApiResponse.loading());

    _myRepo.fetchLeaveTypeList(data).then((value){
      print("response7");
      setLeaveType(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setLeaveType(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchVacationsData (dynamic data , BuildContext context) async {

    setVacationsData(ApiResponse.loading());
    print("response8");
    _myRepo.fetchVacationsData(data).then((value){

      setVacationsData(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setVacationsData(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchGetApprovalHiostry(dynamic data , BuildContext context) async {

    setGetApprovalH(ApiResponse.loading());
    print("response8");
    _myRepo.fetchGetApprovalHiostry(data).then((value){

      setGetApprovalH(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setGetApprovalH(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchAllEmpList (  BuildContext context) async {

    setAllEmployee(ApiResponse.loading());

    _myRepo.fetchAllEmpList().then((value){
      print("response7");
      setAllEmployee(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setAllEmployee(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchStatesV (  BuildContext context) async {

    setRequstStatess(ApiResponse.loading());

    _myRepo.fetchStatesV().then((value){
      print("response7");
      setRequstStatess(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setRequstStatess(ApiResponse.error(error.toString()));

    });
  }



  Future<void> SaveVactEmp (dynamic data,String Lan,BuildContext context)async{
    setLoading(true);

    setCheckINOUT(ApiResponse.loading());

   await _myRepo.GetCheckInOut(data).then((value){
      setLoading(false);
      setCheckINOUT(ApiResponse.completed(value));
      print(value.list![0].msg.toString());
      setchex(value.list![0].msgID!);
      if(value.list![0].msgID==1)
      {

        if(Lan=='AR')
          {
            Utils.flushBarSussMessage(value.list![0].msg.toString(),context);

          }
        else
          {
            Utils.flushBarSussMessage(value.list![0].msgEN.toString(),context);
          }

      }
      else {
        if(Lan=='AR')
        {
          Utils.flushBarErrorMessage(value.list![0].msg.toString(),context);
        }
        else
          {
            Utils.flushBarErrorMessage(value.list![0].msgEN.toString(), context);
          }

      }
    }).onError((error, stackTrace){

      setLoading(false);
      setCheckINOUT(ApiResponse.error(error.toString()));

    });
  }



  Future<void> SaveApproval (dynamic data,String Lan,BuildContext context)async{
    setLoading(true);

    setApprovals(ApiResponse.loading());

    _myRepo.setapproval(data).then((value){
      setLoading(false);
      setApprovals(ApiResponse.completed(value));
      print(value.list![0].msg.toString());
      if(value.list![0].msgID==1)
      {
        setchex(value.list![0].msgID!);
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.task_screen,(Route<dynamic> route) => false);
        if(Lan=='AR')
        {
          Utils.flushBarSussMessage(value.list![0].msg.toString(),context);
        }
        else
        {
          Utils.flushBarSussMessage(value.list![0].msgEN.toString(),context);
        }

      }
      else {
        setchex(value.list![0].msgID!);

        if(Lan=='AR')
        {

          Utils.flushBarErrorMessage(value.list![0].msg.toString(),context);
        }
        else
        {


          Utils.flushBarErrorMessage(value.list![0].msgEN.toString(), context);
        }

      }
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage(error.toString(),context);

      setLoading(false);
      setCheckINOUT(ApiResponse.error(error.toString()));

    });
  }
}