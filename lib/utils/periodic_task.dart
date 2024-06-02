
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/services/GlobalVal.dart';
import 'package:mvvm/view_model/user_view_model.dart';

class PeriodicTask with WidgetsBindingObserver {
  void start() {
    WidgetsBinding.instance?.addObserver(this);

    // Timer.periodic(Duration(seconds: 3), (timer) async{
    //   if (WidgetsBinding.instance?.lifecycleState == AppLifecycleState.paused) {
    //     print('App closed');
    //   } else {
    //    int usermodel = AuthViewModel().UserName;
    //     String name =await DatabaseHelper.gettempName();
    //     await DatabaseHelper.updatename(name);
    //     print('App running');
    //   }
    // });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
    await  DatabaseHelper.updatename('');
      print('App paused ${DateTime.now()}');
      
    } else if (state == AppLifecycleState.resumed) {
        String name = GloablVal.User.toString();
        await DatabaseHelper.updatename(name);
      print('App resumed ${DateTime.now()}');
    }
  }
}

