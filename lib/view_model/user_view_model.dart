
import 'package:flutter/cupertino.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/view_model/services/GlobalVal.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier{
String? _Username;
setUsername(String Username){
  _Username = Username;
  notifyListeners();
}
String? get Username => _Username;

  Future<bool> saveUser(UserModel user)async{
 await DatabaseHelper.updateEmpNo(user.Username.toString());
 await DatabaseHelper.updatePassword(user.Password.toString());
    // final SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.setString('Username', user.Username.toString());
    // sp.setString('Password', user.Password.toString());
    notifyListeners();
    return true ;
  }
  Future<bool> updatename(String user)async{
 await DatabaseHelper.updatename(user.toString());
 print(DatabaseHelper.getName());
    notifyListeners();
    return true ;
  }

  Future<UserModel> getUser()async{

 String Username =await DatabaseHelper.getEmpNo();
  String Password =await DatabaseHelper.getPassword();
    // final SharedPreferences sp = await SharedPreferences.getInstance();
    // final String? Username = sp.getString('Username');
    // final String? Password = sp.getString('Password');


    return UserModel(
        Username: Username.toString(),
        Password: Password.toString()
    );
  }
  Future<String> getName()async{

 String Username =await DatabaseHelper.getName();


    return Username.toString();
  }

  Future<bool> remove()async{
    await DatabaseHelper.updateEmpNo('');
    await DatabaseHelper.updatePassword('');

    // final SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.remove('Username');
    // sp.remove('Password');
    return true;

  }
}