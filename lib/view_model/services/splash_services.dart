
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/services/GlobalVal.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {


  Future<UserModel> getUserDate() => UserViewModel().getUser();


  void checkAuthentication(BuildContext context)async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
     final String Lan = await DatabaseHelper.getLang();
    // final String Lan = sp.getString('Lan')!=null? sp.getString('Lan')!:"EN";
    final String them = sp.getString('them')!=null? sp.getString('them')!:"#86166D";

    if(Lan == 'null'||Lan=='')
      {
        final userPreference = Provider.of<Language>(context , listen: false);
        userPreference.setLanguage('EN');
      }
    else
      {
        final userPreference = Provider.of<Language>(context , listen: false);
        userPreference.setLanguage(Lan);
      }
    if(them == 'null'||them=='')
      {
        final userPreference = Provider.of<Language>(context , listen: false);
        userPreference.setColor('#86166D');
      }
    else
      {
        final userPreference = Provider.of<Language>(context , listen: false);
        userPreference.setColor(them);
      }
    getUserDate().then((value)async{

    //  print(value.token.toString());

      if(value.Username.toString() == 'null' || value.Username.toString() == ''){
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.login);
      }else {
        await  Future.delayed(Duration(seconds: 3));
        final userPreference = Provider.of<AuthViewModel>(context , listen: false);
        userPreference.setuserName(int.parse(value.Username.toString()));

        Navigator.pushReplacementNamed(context, RoutesName.homeHR);
      }

    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    });

  }



}