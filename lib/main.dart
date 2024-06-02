import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvvm/res/app_url.dart';
import 'package:mvvm/utils/periodic_task.dart';
import 'package:mvvm/utils/routes/routes.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/Home/HomeNew_View_Model.dart';
import 'package:mvvm/view_model/MyRequest_View_Model/My_Request_ViewModel.dart';
import 'package:mvvm/view_model/Profile/Profile_View_Model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/services/GlobalVal.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';
import 'package:mvvm/view_model/services/NotificationService.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'data/network/BaseApiServices.dart';
import 'data/network/NetworkApiService.dart';
import 'model/Profile/GetNotifiModel.dart';
import 'model/user_model.dart';
import 'view_model/Vacations/Vacations_view_model.dart';

String language = "";
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
var LanguageProvider;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GloablVal.initialize();
    await DatabaseHelper.initializeDB();
    

  // Run the periodic task in the background (isolate)
   var task = PeriodicTask();
  task.start();
  // initializeService();
  // NotificationService().initNotification();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => HomeNewViewModel()),
      ChangeNotifierProvider(create: (_) => My_Request_ViewModel()),
      ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ChangeNotifierProvider(create: (_) => Language()),
      ChangeNotifierProvider( create: (_)=> Vacationsviewmodel()),
     ChangeNotifierProvider(create: (_)=> UserViewModel())
    ], child: MyApp(),
  ));
  initializeService();
  NotificationService().initNotification();

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     LanguageProvider = Provider.of<Language>(context, listen: false);

    return MaterialApp(
      title: 'GALAXY HRMS',
      useInheritedMediaQuery: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

const notificationChannelId = 'my_foreground';
const notificationId = 888;
bool isServiceRunning = false;
 GetNotifiModel? x1;
 FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;



Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    'MY FOREGROUNDSERVICE',
    description: 'hello world',
    importance: Importance.max,

  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      foregroundServiceNotificationId: 33,
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
    ),
  );



  service.startService();
}



@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  Future<UserModel> getUserDate() => UserViewModel().getUser();
    Future<String> getname() => UserViewModel().getName();

  isServiceRunning = true;

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (isServiceRunning) {
      getUserDate().then((value) async {
        if (value.Username.toString() == 'null' ||
            value.Username.toString() == '' ) {
          await Future.delayed(Duration(seconds: 1));
          // final SharedPreferences sp = await SharedPreferences.getInstance();
          final String Lan = await DatabaseHelper.getLang();
          String name =await getname();
          int empNo = 0;
          log("value $name" , name: 'value');
if(name == "null" ){
  empNo = 0;
}else if (name == ""){
  empNo = 0;
}else{
  empNo = int.parse(name);
}
        
    
          Map data = {
            'emp_No':empNo,
            'id': 1,
            'date':  Lan,
          };
          print(data.toString());
          x1 = await GetNotifidataSend(data);
        } else {
          await Future.delayed(Duration(seconds: 3));
          // final SharedPreferences sp = await SharedPreferences.getInstance();
          final String Lan = await DatabaseHelper.getLang();
          // final String Lan = sp.getString('Lan')!=null? sp.getString('Lan')!:"EN";

          Map data = {
            'emp_No': int.parse(value.Username.toString()),
            'id': 1,
            'date':  Lan,
          };
          print(data.toString());
          x1 = await GetNotifidataSend(data);
        }
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print(error.toString());
        }
      });

      if (x1 != null && x1!.list != null && x1!.list!.isNotEmpty) {

      for(int i =0 ; i<x1!.list!.length;i++)
        {
          NotificationService().showNotification(
              id: int.parse(x1!.list![i].notiDisplayID!),
              title:x1!.list![i].fieldValEn,
              body: x1!.list![i].fieldVal
          );
        }
        }

    }
  });
}
Future<GetNotifiModel> GetNotifidataSend(dynamic data) async {
  BaseApiServices _apiServices = NetworkApiService();
  try {
    print(AppUrl.GetNotifDataSend);
    String json = jsonEncode(data);
    print(json.toString());
    String ip = await DatabaseHelper.getIP();
    log("ip $ip");
    dynamic response = await _apiServices.getPostApiResponse1(
     ip + '/GetNotifDataSend',
      json,
    );

    return response = GetNotifiModel.fromJson(response);
  } catch (e) {
    print("response2" + e.toString());
    return GetNotifiModel();
  }
}

void showLocalNotification(String message) async {
  
  if (flutterLocalNotificationsPlugin != null) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      notificationChannelId,
      'MY FOREGROUNDSERVICE1dss',
      channelDescription: 'hello world',
      importance: Importance.low,
      priority: Priority.low,
        visibility: NotificationVisibility.secret,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin!.show(
      notificationId,
      "HRMS GALAXY",
      message,
      platformChannelSpecifics,
    );
  }
  
}


