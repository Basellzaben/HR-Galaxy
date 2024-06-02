



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/Dialogs/VacationsDialog.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/HomeHR_Screen.dart';
import 'package:mvvm/view/HomeNew.dart';
import 'package:mvvm/view/Leave_Screen.dart';
import 'package:mvvm/view/MyRequest_Screen.dart';
import 'package:mvvm/view/Profie_Screen/View/Profile_Screen.dart';
import 'package:mvvm/view/Vacatlon_Screen.dart';
import 'package:mvvm/view/home_screen.dart';
import 'package:mvvm/view/login_view.dart';
import 'package:mvvm/view/signp_view.dart';
import 'package:mvvm/view/splash_view.dart';
import 'package:mvvm/view/task_screen.dart';

import '../../Dialogs/DitalsRequest_Dialog.dart';
import '../../Dialogs/DitalsTask_Dialog.dart';
import '../../view/Attendance_ٍScreen.dart';
import '../../view/DitalsRequest_Screen.dart';
import '../../view/DitalsTask_Screen.dart';
import '../../view/Salaryslip_Screen.dart';
import '../../view/notifications_screen.dart';

class Routes {

  static Route<dynamic>  generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context) => const SignUpView());
      case RoutesName.homeHR:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeNew());
        case RoutesName.VacatlonScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const VacatlonScreen());
        case RoutesName.VacationsDialog:
        return MaterialPageRoute(builder: (BuildContext context) => const VacationsDialog());
        case RoutesName.LeaveScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const LeaveScreen());
        case RoutesName.MyRequestScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const MyRequest_Screen());
        case RoutesName.task_screen:
        return MaterialPageRoute(builder: (BuildContext context) => const task_screen());
        case RoutesName.ProfileScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const ProfileScreen());
  case RoutesName.SalaryslipScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const Salaryslip_Screen());
  case RoutesName.notifications_screen:
        return MaterialPageRoute(builder: (BuildContext context) => const notifications_screen());
  case RoutesName.AttendanceScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const AttendanceScreen());
        case RoutesName.DitalsRequest_Screen:
        return MaterialPageRoute(builder: (BuildContext context) => const DitalsRequest_Screen());
  case RoutesName.DitalsTask_Screen:
        return MaterialPageRoute(builder: (BuildContext context) => const DitalsTask_Screen());

      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });

    }
  }
}