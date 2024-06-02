

import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/MyRequest/MyRequestModel.dart';
import 'package:mvvm/model/MyRequest/TaskModel.dart';
import 'package:mvvm/model/Vacations/AllEmployeeModel.dart';
import 'package:mvvm/model/Vacations/VacationsTypeModel.dart';

import 'package:mvvm/respository/MyRequest/MyRequest_Respository.dart';




class My_Request_ViewModel with ChangeNotifier {

  final _myRepo = MyRequestRespository();
  bool _loading = false ;
  bool get loading => _loading ;
  int  RequestType = 0 ;
  int  RequestNo = 0 ;
  int  Requesteww = 0 ;
  int  Requesteww3 = 0 ;
  int  RequestWorkFlow = 0 ;
  String RequestName="";
  String RequestTypeName="";
  String TypeRequset="";
  String StartDate="";
  String EndDate="";
  String StartTime="";
  String EndTime="";

  setDital1(String TypeRequset, String StartDate, String EndDate) {

    this.TypeRequset = TypeRequset;
    this.StartDate = StartDate;
    this.EndDate = EndDate;


    notifyListeners();
  }
  setDital2(String TypeRequset, String StartTime, String EndTime ,String StartDate) {

    this.TypeRequset = TypeRequset;
    this.StartTime = StartTime;
    this.EndTime = EndTime;
    this.StartDate = StartDate;


    notifyListeners();
  }
  setRequestType(int RequestType, String RequestTypeName) {

    this.RequestType = RequestType;
    this.RequestTypeName = RequestTypeName;


    notifyListeners();
  }
  setRequestWorkFlow(int RequestWorkFlow) {

    this.RequestWorkFlow = RequestWorkFlow;



    notifyListeners();
  }
  setRequesteww(int Requesteww) {

    this.Requesteww = Requesteww;



    notifyListeners();
  }
  setRequesteww3(int Requesteww3) {

    this.Requesteww3 = Requesteww3;



    notifyListeners();
  }
  setRequest(int RequestNo, String RequestName) {
    this.RequestNo = RequestNo;
    this.RequestName = RequestName;


    notifyListeners();
  }
  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }


  ApiResponse<MyRequestModel> MyRequestData = ApiResponse.loading();
  ApiResponse<MyRequestModel> MyRequestDatadetails = ApiResponse.loading();
  ApiResponse<TaskModel> TaskDatadetails = ApiResponse.loading();
  ApiResponse<TaskModel> TaskData = ApiResponse.loading();
  ApiResponse<VacationsTypeModel> AllRequst = ApiResponse.loading();


  setMyRequestData(ApiResponse<MyRequestModel> response){

    MyRequestData = response ;
    print ("response10"+response.toString());
    notifyListeners();
  }
 setMyRequestDatadetails(ApiResponse<MyRequestModel> response){

   MyRequestDatadetails = response ;
    print ("response10"+response.toString());
    notifyListeners();
  }
  setTaskData(ApiResponse<TaskModel> response){

    TaskData = response ;

    notifyListeners();
  }
 setTaskDatadetails(ApiResponse<TaskModel> response){

   TaskDatadetails = response ;
    print ("response10"+response.toString());
    notifyListeners();
  }
  setAllRequst(ApiResponse<VacationsTypeModel> response){
    print("response7"+response.data.toString());
    AllRequst = response ;

    notifyListeners();
  }


  Future<void> fetchMyRequestData(dynamic data , BuildContext context) async {

    setMyRequestData(ApiResponse.loading());

    _myRepo.fetchMyRequestData(data).then((value){

      setMyRequestData(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setMyRequestData(ApiResponse.error(error.toString()));

    });
  }
 Future<void> fetchMyRequestDatadetails(dynamic data , BuildContext context) async {

    setMyRequestDatadetails(ApiResponse.loading());

    _myRepo.fetchMyRequestDatadetails(data).then((value){

      setMyRequestDatadetails(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setMyRequestDatadetails(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchTaskData(dynamic data , BuildContext context) async {

    setTaskData(ApiResponse.loading());

    _myRepo.fetchTaskData(data).then((value){

      setTaskData(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setTaskData(ApiResponse.error(error.toString()));

    });
  }
 Future<void> fetchTaskDatadetails(dynamic data , BuildContext context) async {

   setTaskDatadetails(ApiResponse.loading());

    _myRepo.fetchTaskDatadetails(data).then((value){

      setTaskDatadetails(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setTaskDatadetails(ApiResponse.error(error.toString()));

    });
  }
  Future<void> fetchAllRequst( dynamic data , BuildContext context) async {

    setAllRequst(ApiResponse.loading());

    _myRepo.fetchAllRequst(data).then((value){
      print("response7");
      setAllRequst(ApiResponse.completed(value));


    }).onError((error, stackTrace){

      setAllRequst(ApiResponse.error(error.toString()));

    });
  }


}