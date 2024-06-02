

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/model/Home/CheckInOutModel.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/respository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/services/GlobalVal.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/api_response.dart';

class AuthViewModel with ChangeNotifier {
  int UserName =-1;
  String Name ="";
  setuserName(int Username)
  {
    UserName =Username;
  }

  setName(String Name)
  {
    this.Name =Name;
  }

  final _myRepo = AuthRepository();

  bool _loading = false ;
  bool get loading => _loading ;

  bool _signUpLoading = false ;
  bool _ChangeLogin = false ;
  bool get signUpLoading => _signUpLoading ;
  bool get ChangeLoginLoading => _ChangeLogin ;

  ApiResponse<CheckInOutModel> ChangeLogin2 = ApiResponse.loading();
  setChangeLogin(ApiResponse<CheckInOutModel> response){
    ChangeLogin2 = response ;
    notifyListeners();
  }

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }


  Future<void> loginApi(dynamic data ,bool CHAX, BuildContext context) async {

    setLoading(true);

    _myRepo.loginApi(data).then((value){

      setLoading(false);


      final userPreference = Provider.of<UserViewModel>(context , listen: false);


    
     

if (value['login']==1)
  {
    print(int.parse(data["Username"].toString()));
    print("int.parse(data[Username].toString())");
    setuserName(int.parse(data["Username"].toString()));
        userPreference.updatename(data['Username'].toString());

    Utils.flushBarErrorMessage('Login Successfully', context);
      if (CHAX==true)
        {
      userPreference.saveUser(
        UserModel(
          Username: data['Username'].toString(),
          Password: data['Password'].toString()
        )
      );}
    Navigator.pushNamed(context, RoutesName.homeHR);
    if(kDebugMode){
      print(value.toString());

    }
    }
else
      {
        setLoading(false);
        Utils.flushBarErrorMessage("The username and password are incorrect", context);
      }

    }).onError((error, stackTrace){
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);

      if(kDebugMode){
        print(error.toString());

      }

    });
  }

  Future<void> ChangeLogin(dynamic data ,String Lan, BuildContext context) async {

    setLoading(true);
    setChangeLogin(ApiResponse.loading());
    _myRepo.ChangeLogin(data).then((value){
      setLoading(false);

      setChangeLogin(ApiResponse.completed(value));
      print(value.list![0].msg.toString());
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
      Utils.flushBarErrorMessage(error.toString(), context);

      if(kDebugMode){
        print(error.toString());

      }

    });
  }


  Future<void> signUpApi(dynamic data , BuildContext context) async {

    setSignUpLoading(true);

    _myRepo.signUpApi(data).then((value){
      setSignUpLoading(false);
      Utils.flushBarErrorMessage('SignUp Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());

      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if(kDebugMode){
        print(error.toString());
      }

    });
  }

}