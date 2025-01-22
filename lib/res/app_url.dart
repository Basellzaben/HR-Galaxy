

// ignore_for_file: non_constant_identifier_names

import '../view_model/services/GlobalVal.dart';

class AppUrl {


//static var baseUrl = 'http://10.0.1.50:8521' ;
//static var baseUrl = 'http://94.249.83.196:9072' ;

//static var baseUrl = 'http://94.249.127.221:3750' ; //MARKA
//static var baseUrl = 'http://46.185.139.240:3750' ; //electroneaty
//static var baseUrl = 'http://194.165.159.181:3750' ; //3en
//static var baseUrl = 'http://10.0.1.60:88' ;
//static var baseUrl = 'http://10.0.1.50:3755' ;
 //static var baseUrl = 'http://192.168.1.140:8521' ;

  static var moviesBaseUrl = 'https://dea91516-1da3-444b-ad94-c6d0c4dfab81.mock.pstmn.io/' ;
  static Future<String?> buildUrl(String endpoint) async {
    final String? ip = await DatabaseHelper.getIP();
    if (ip != null && ip.isNotEmpty) {
      return '$ip$endpoint';
    } else {
      // Handle the case when IP is null or empty
      return endpoint;
    }
  }
  Future<String> getIP() {
    return DatabaseHelper.getIP();
  }

//create get method to get ip future<string>to set in string value


static Future<String> getLoginEndPoint() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/ChxLogin';
}

  //static var loginEndPint =   getIP+ '/ChxLogin' ;
 // static var registerApiEndPoint =  "http://94.249.83.196:9072" + '/api/register' ;

  static Future<String> registerApiEndPoint() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/api/register';
}

  static var moviesListEndPoint =  '${moviesBaseUrl}movies_list' ;
  
 // static var GetVacatiosType =  "http://94.249.83.196:9072" + '/GetVacatiosType' ;
  static Future<String> GetVacatiosType() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetVacatiosType';
}
 // static var GetHomeData =  "http://94.249.83.196:9072" + '/GetHomeData' ;

   static Future<String> GetHomeData() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetHomeData';
}
  //static var GETAllEmployees =  "http://94.249.83.196:9072" + '/GETAllEmployees' ;

   static Future<String> GETAllEmployees() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GETAllEmployees';
}
 // static var GetLeaveType =  "http://94.249.83.196:9072" + '/GetLeaveType' ;
     static Future<String> GetLeaveType() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetLeaveType';
}
  //static var GetMyRequestData =  "http://94.249.83.196:9072" + '/GetMyRequestData' ;

   static Future<String> GetMyRequestData() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetMyRequestData';
}
  
//  static var GetMyRequestType =  "http://94.249.83.196:9072" + '/GetMyRequestType' ;
     static Future<String> GetMyRequestType() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetMyRequestType';
}
 // static var GetTaskData =  "http://94.249.83.196:9072" + '/GetTaskData' ;
    static Future<String> GetTaskData() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetTaskData';
}
  //static var CheckINOUT =  "http://94.249.83.196:9072" + '/CheckINOUT' ;
     static Future<String> CheckINOUT() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/CheckINOUT';
}
  //static var SaveVacatiosData =  "http://94.249.83.196:9072" + '/SaveVacatiosData' ;
    static Future<String> SaveVacatiosData() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/SaveVacatiosData';
}
  // static var ChangeLogin =  "http://94.249.83.196:9072" + '/ChangeLogin' ;
      static Future<String> ChangeLogin() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/ChangeLogin';
}
  // static var setApprovaldata =  "http://94.249.83.196:9072" + '/setApprovaldata' ;
      static Future<String> setApprovaldata() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/setApprovaldata';
}
  // static var GetProfileData =  "http://94.249.83.196:9072" + '/GetProfileData' ;
      static Future<String> GetProfileData() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetProfileData';
}
      static Future<String> GetCalenderData() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetClnder';
}
      static Future<String> GetTimeLine() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetTimeLine';
}
      static Future<String> GetSalary() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetSalary';
}
  // static var GetBalanceData =  "http://94.249.83.196:9072" + '/GetBalanceData' ;
      static Future<String> GetBalanceData() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetBalanceData';
}
  // static var GetTimeData =  "http://94.249.83.196:9072" + '/GetTimeData' ;
      static Future<String> GetTimeData() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetTimeData';
}
  // static var GetApprovalH =  "http://94.249.83.196:9072" + '/GetApprovalH' ;
      static Future<String> GetApprovalH() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetApprovalH';
}
  // static var GetHdeSalaryslip =  "http://94.249.83.196:9072" + '/GetHdeSalaryslip' ;
      static Future<String> GetHdeSalaryslip() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetHdeSalaryslip';
}
  // static var GetSalaryslip =  "http://94.249.83.196:9072" + '/GetSalaryslip' ;
      static Future<String> GetSalaryslip() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetSalaryslip';
}
  // static var GetAttendance =  "http://94.249.83.196:9072" + '/GetAttendance' ;
      static Future<String> GetAttendance() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetAttendance';
}
  static Future<String> GetAttendanceMap() async {
    String ip = await DatabaseHelper.getIP();
    return '$ip/GetPlanAtt';
  }
  // static var GetNotiData =  "http://94.249.83.196:9072" + '/GetNotiData' ;
      static Future<String> GetNotiData() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetNotiData';
}
  // static var GetNotifDataSend = "http://94.249.83.196:9072" + '/GetNotifDataSend' ;
      static Future<String> GetNotifDataSend() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetNotifDataSend';
}
  // static var deleteRequst =  "http://94.249.83.196:9072" + '/deleteRequst' ;
      static Future<String> deleteRequst() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/deleteRequst';
}
  // static var GetImageModel =  "http://94.249.83.196:9072" + '/GetImageModel' ;
      static Future<String> GetImageModel() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetImageModel';
}
  // static var GetVacatiosData =  "http://94.249.83.196:9072" + '/GetVacatiosData' ;
      static Future<String> GetVacatiosData() async {
  String ip = await DatabaseHelper.getIP();
  return '$ip/GetVacatiosData';
}


}