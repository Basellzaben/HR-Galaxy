


// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/Home/GetImageModel.dart';
import 'package:mvvm/model/Home/HomeNewModel.dart';
import 'package:mvvm/respository/Home/HomeNewRepository.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/Home/CheckInOutModel.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../Vacations/Vacations_view_model.dart';
import '../services/LanguagePrvider.dart';

class HomeNewViewModel with ChangeNotifier {
  String? lat ="0.0";
  String? long ="0.0";
  String? ID ="0.0";
  String? ActionNo ="0.0";
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;
  setcurrentPosition(Position? value) {
    _currentPosition = value;
    notifyListeners();
  }

  setData (String? ID,String? ActionNo)
  {
    lat=_currentPosition!.latitude.toString();
    long=_currentPosition!.longitude.toString();
    this.ID=ID;
    this.ActionNo=ActionNo;
    notifyListeners();
  }
  final _myRepo = HomeNewRepository();
  bool _loading = false ;
  bool get loading => _loading ;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }
  ApiResponse<HomeNewModel> HomeData = ApiResponse.loading();
  ApiResponse<CheckInOutModel> CheckINO = ApiResponse.loading();
  ApiResponse<CheckInOutModel> deleteReq = ApiResponse.loading();
  ApiResponse<GetImageModel> getimage = ApiResponse.loading();

  setHomeData(ApiResponse<HomeNewModel> response){
    HomeData = response ;
    notifyListeners();
  }
  setgetimage(ApiResponse<GetImageModel> response){
    getimage = response ;
    notifyListeners();
  }
  setdeleteReq(ApiResponse<CheckInOutModel> response){
    deleteReq = response ;
    notifyListeners();
  }
 setCheckINOUT(ApiResponse<CheckInOutModel> response){
   CheckINO = response ;
    notifyListeners();
  }


  Future<void> getHomeData (dynamic data,String lan,BuildContext context)async{

    setHomeData(ApiResponse.loading());

    _myRepo.GetHomeData(data).then((value){
      print(value.list![0].englishName.toString());
      if(lan=="AR")
        {
          context.read<AuthViewModel>().setName(value.list![0].arabicName.toString());

        }
      else
        {
          context.read<AuthViewModel>().setName(value.list![0].englishName.toString());

        }
      setHomeData(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setHomeData(ApiResponse.error(error.toString()));

    });
  }

 Future<void> GetCheckInOut (dynamic data,BuildContext context)async{
   setLoading(true);

   print(data.toString());

   setCheckINOUT(ApiResponse.loading());

    _myRepo.GetCheckInOut(data).then((value){
      setLoading(false);
      setCheckINOUT(ApiResponse.completed(value));
      if(value.list![0].msgID==1)
        {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<Vacationsviewmodel>().setINOUT1(-1, '');

          });
          var LanguageProvider1 = Provider.of<Language>(context, listen: false);

          var lang =  LanguageProvider1.getLanguage();
          Utils.flushBarSussMessage(lang == "EN" ? value.list![0].msgEN.toString() : value.list![0].msg.toString() ,context);
          String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
          print(context.read<AuthViewModel>().UserName);

          Map data = {
            'EmployeeNo': context.read<AuthViewModel>().UserName,
            'StartDate': currentDate.toString(),
          };
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final viewModel = context.read<HomeNewViewModel>();
            viewModel.getHomeData(data, LanguageProvider1.getLanguage(), context);
          });
        }

      else {
        Utils.flushBarErrorMessage(value.list![0].msg.toString(), context);
      }
        }).onError((error, stackTrace){

      setLoading(false);
      setCheckINOUT(ApiResponse.error(error.toString()));

    });
  }
 Future<void> set_deleteReq (dynamic data,BuildContext context)async{
   setLoading(true);

print(data.toString());
   setdeleteReq(ApiResponse.loading());

  await  _myRepo.set_deleteReq(data).then((value){
      setLoading(false);
      setdeleteReq(ApiResponse.completed(value));
      if(value.list![0].msgID==1)
        {
           var LanguageProvider1 = Provider.of<Language>(context, listen: false);

          var lang =  LanguageProvider1.getLanguage();
  Utils.flushBarSussMessage(lang == "EN" ? value.list![0].msgEN.toString() : value.list![0].msg.toString(),context);
  Future.delayed(Duration(seconds: 1), () {
  Navigator.pushNamedAndRemoveUntil(
    context,
    RoutesName.MyRequestScreen,
    (Route<dynamic> route) => false,
  );
});
 
        }

      else {
        Utils.flushBarErrorMessage(value.list![0].msg.toString(), context);
      }
        }).onError((error, stackTrace){

      setLoading(false);
      setdeleteReq(ApiResponse.error(error.toString()));

    });
  }
 Future<void> GetImageVM (dynamic data,BuildContext context)async{
   setLoading(true);

print(data.toString());
   setgetimage(ApiResponse.loading());

    _myRepo.GetImageRep(data).then((value){
      setLoading(false);
      setgetimage(ApiResponse.completed(value));



        }).onError((error, stackTrace){

      setLoading(false);
      setgetimage(ApiResponse.error(error.toString()));

    });
  }


  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  
  Future<void> getCurrentPosition(BuildContext context) async {
    setLoading(true);
    final hasPermission = await _handleLocationPermission(context);

    if (!hasPermission) return;
    Position _position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
    print(_position.latitude);
    setcurrentPosition(_position);
    setLoading(false);

    // await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
    //     .then((Position position) {
    //       print(position.latitude);
    //       setcurrentPosition(position);
    
    // }).catchError((e) {
    //   debugPrint(e);
    // });
  }
}