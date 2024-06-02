import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm/Dialogs/DitalsRequest_Dialog.dart';
import 'package:mvvm/Dialogs/RequestType_Dialog.dart';
import 'package:mvvm/Dialogs/Request_Dialog.dart';

import 'package:mvvm/Dialogs/VacationsDialog.dart';
import 'package:mvvm/data/response/status.dart';

import 'package:mvvm/res/components/round_button.dart';

import 'package:mvvm/view_model/MyRequest_View_Model/My_Request_ViewModel.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Dialogs/VacationsStatusDialog.dart';
import '../Dialogs/myrido.dart';
import '../res/components/constants.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/services/LanguagePrvider.dart';

class MyRequest_Screen extends StatefulWidget {
  const MyRequest_Screen({Key? key}) : super(key: key);

  @override
  _MyRequest_ScreenState createState() => _MyRequest_ScreenState();
}
enum SingingCharacter { lafayette, jefferson }
class _MyRequest_ScreenState extends State<MyRequest_Screen> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  My_Request_ViewModel my_Request_ViewModel = My_Request_ViewModel();
  TextEditingController _Startdate = TextEditingController();
  TextEditingController _Enddate = TextEditingController();
  TextEditingController _RequestType = TextEditingController();
  TextEditingController _VacationsType = TextEditingController();
  TextEditingController _Requst = TextEditingController();
  TextEditingController _EmpName = TextEditingController();
  TextEditingController _AlternateEmployee = TextEditingController();
  final DateFormat format1 = DateFormat('MMM');
 late String? StartYear="",StartMonth="",StartDay="";
  late String? EndYear="",EndMonth="",EndDay="";
  late String? LeaveYear="",LeaveMonth="",LeaveDay="";
  late String? TimeStart="",TimeEnd="";
  List months = ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];
  late DateTime startDateTime  ;
  late DateTime endDateTime;
  NumberFormat formatter = new NumberFormat("00");



  @override
  void initState() {
    // TODO: implement initState
    //homeViewViewModel.fetchMoviesListApi();
    /*   _EmpName.text=  context.read<AuthViewModel>().Name;
    print('AlertDialog dismissed ' +
        context.read<Vacationsviewmodel>().VacationsTypeName);
    _VacationsType.text = context.read<Vacationsviewmodel>().VacationsTypeName;
    CalDayNumber(1);*/
    Map data = {
      "EmployeeNo": context.read<AuthViewModel>().UserName,
      "ActionNo": 2,
      "vac_type": -1,
      "WFReqType": -1,
      "ID": -1,
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<My_Request_ViewModel>().setRequest(0,"");
      context.read<My_Request_ViewModel>().setRequestType(0,"");

      final viewModel = context.read<My_Request_ViewModel>();
      viewModel.fetchMyRequestData(data, context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool myRequestFinished = true;

   double width = MediaQuery.of(context).size.width;
    double sc = MediaQuery.of(context).textScaleFactor;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final fontSize = 20 / textScaleFactor;
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.homeHR,
                (Route<dynamic> route) => false);

        return false;
      },
      child: Directionality(
        textDirection: LanguageProvider.getDirection(),
        child: Scaffold(
            backgroundColor: ColorTheme(context),
            body: SafeArea(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),

                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child:
                        Row(

                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            Container(
                              padding: EdgeInsets.only(left: 30, right: 30, top: 0),

                              child:Row(
                                children: [
                                  Image.asset(
                                    "assest/request.png",
                                    width: 45,
                                    height: 45,
                                    color: ColorTheme(context),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width * 0.025,
                                  ),
                                  textWidget(
                                      LanguageProvider.Llanguage('MyRequest'), 25/sc, FontWeight.w500, Colors.black)
                                ],
                              ),
                            )

                            ,
                            Spacer(),
                            Container(
                              padding: EdgeInsets.only(left: 30, right: 30, top: 0),

                              alignment: Alignment.topLeft,

                              child: InkWell(
                                onTap: () {

                                  //   Navigator.pushNamed(context, RoutesName.homeHR);
                                  //   Navigator.pop(context);
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, RoutesName.homeHR,(Route<dynamic> route) => false);
                                },
                                child:  RotatedBox(
                                  quarterTurns: LanguageProvider.getLanguage()=="AR"?2:2,
                                  child:  Icon(
                                    Icons.arrow_back_ios_new,
                                    color: ColorTheme(context),
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(

                      margin: EdgeInsets.only(top: 30, left: 30,right: 25),
                      child:
                      AutoSizeText(LanguageProvider.Llanguage(
                            'Order'),
                        style: TextFormFieldColor(context),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height /16,
                      width: MediaQuery.sizeOf(context).width ,
                      margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: TextFormField(
                        readOnly: true,
                        style: ColorBlack(context),
                        controller: _Requst,
                        decoration: InputDecoration(
                          /*   prefixIcon: Icon(Icons.person),*/
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                          labelStyle: ColorBlack(context),
                          hintStyle: ColorBlack(context),
                          suffixIcon: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return WillPopScope(
                                          onWillPop: () async {
                                            // Perform custom action when AlertDialog is closed

                                            return true;
                                          },
                                          child: Request_Dialog());
                                    }).then((value) {
                                  _Requst.text = context
                                      .read<My_Request_ViewModel>()
                                      .RequestName;




                                });
                              },
                              child: Icon(
                                size: 35,
                                Icons.keyboard_arrow_down,
                                color: ColorTheme(context),
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderSide: SBorderside(context),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: SBorderside(context),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width ,
                      margin: EdgeInsets.only(top: 10, left: 25,right: 25),
                      child: AutoSizeText(
                        LanguageProvider.Llanguage(
                            'requesttype'),
                        style: TextFormFieldColor(context),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.sizeOf(context).width ,
                      margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: TextFormField(
                        readOnly: true,
                        style: ColorBlack(context),
                        controller: _RequestType,
                        decoration: InputDecoration(
                          /*   prefixIcon: Icon(Icons.person),*/
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 5.0),
                          labelStyle: ColorBlack(context),
                          hintStyle: ColorBlack(context),
                          suffixIcon: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return WillPopScope(
                                          onWillPop: () async {

                                            return true;
                                          },
                                          child: RequestType_Dialog());
                                    }).then((value) {
                                  _RequestType.text = context
                                      .read<My_Request_ViewModel>()
                                      .RequestTypeName;




                                });
                              },
                              child: Icon(
                                size: 35,
                                Icons.keyboard_arrow_down,
                                color: ColorTheme(context),
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderSide: SBorderside(context),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: SBorderside(context),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 15,right: 15),
                      width: MediaQuery.sizeOf(context).width ,
                      height: MediaQuery.sizeOf(context).width/4.8,
                    //  margin: EdgeInsets.only(top: 10, left: 15,right: 15),
                      child: MyStatefulWidget(),
                ),
                 /*   Container(
                      width: MediaQuery.sizeOf(context).width / 2.5,
                      margin: EdgeInsets.only(top: 10, left: 15,right: 15),
                      child: AutoSizeText(
                        LanguageProvider.Llanguage(
                            'reqstatus'),
                        style: TextFormFieldColor(context),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.sizeOf(context).width / 2.5,
                      margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: TextFormField(
                        readOnly: true,
                        style: ColorBlack(context),
                        controller: _VacationsType,
                        decoration: InputDecoration(
                          */
                    /*   prefixIcon: Icon(Icons.person),*//*
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 5.0),
                          labelStyle: ColorBlack(context),
                          hintStyle: ColorBlack(context),
                          suffixIcon: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return WillPopScope(
                                          onWillPop: () async {
                                            // Perform custom action when AlertDialog is closed

                                            return true;
                                          },
                                          child: VacationsStatusDialog());
                                    }).then((value) {
                                  _VacationsType.text = context
                                      .read<Vacationsviewmodel>()
                                      .VstatesName;




                                });
                              },
                              child: Icon(
                                size: 35,
                                Icons.keyboard_arrow_down,
                                color: ColorTheme(context),
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderSide: SBorderside(context),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: SBorderside(context),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),*/
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 0),
                          child: RoundButton(
                            title:  LanguageProvider.Llanguage(
                                'sendrequest'),
                            loading: false,
                            fontSize:fontSize ,
                            onPress: () {
                              Map data = {
                                "EmployeeNo": context.read<AuthViewModel>().UserName,
                                "ActionNo": context.read<Vacationsviewmodel>().Vstates !=0?context.read<Vacationsviewmodel>().Vstates:-1,
                                "vac_type": context.read<My_Request_ViewModel>().RequestNo!=0?context.read<My_Request_ViewModel>().RequestNo:-1,
                                "WFReqType":  context.read<My_Request_ViewModel>().RequestType!=0?context.read<My_Request_ViewModel>().RequestType:-1,
                                "ID": -1,
                              };

                              WidgetsBinding.instance.addPostFrameCallback((_) {


                                final viewModel = context.read<My_Request_ViewModel>();
                                viewModel.fetchMyRequestData(data, context);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 15,right: 15),
                      height: MediaQuery.sizeOf(context).height/1.5,
                   // ,
                      child: Consumer<My_Request_ViewModel>(builder: (context, value, _) {
                        switch (value.MyRequestData.status) {
                          case Status.LOADING:
                            return Center(child: CircularProgressIndicator());
                          case Status.ERROR:
                            return Center(
                                child: AutoSizeText(value.MyRequestData.message.toString()));
                          case Status.COMPLETED:



                            return value.MyRequestData.data!.list!=null ?
                            ListView.builder(
                                itemCount: value.MyRequestData.data!.list!.length,
                                //   physics: const AlwaysScrollableScrollPhysics(), // new
                                shrinkWrap: true,

                                itemBuilder: (context, index) {
                                  var starttime;
                                  var endtime;
                                  var str ;
                                  var stre ;
                                  var Leavedate;
                                  if(  value.MyRequestData.data!.list![index].request==1)
                                  {
                                    var startDate = DateFormat('yyyy-MM-dd').parse(value.MyRequestData.data!.list![index].vacStartDate!);
                                    var endDate = DateFormat('yyyy-MM-dd').parse(value.MyRequestData.data!.list![index].vacEndDate!);

                                    StartYear = startDate.year.toString();
                                    StartMonth = startDate.month.toString();
                                    StartDay = startDate.day.toString();
                                  //  print(StartMonth!);

                                    EndYear = endDate.year.toString();
                                    EndMonth = endDate.month.toString();
                                    EndDay = endDate.day.toString();

                                  }
                                  else
                                  {

                                     Leavedate = DateFormat('yyyy-MM-dd').parse(value.MyRequestData.data!.list![index].leaveDate!);
                                    LeaveYear = Leavedate.year.toString();
                                    LeaveMonth = Leavedate.month.toString();
                                    LeaveDay = Leavedate.day.toString();

                                     str = value.MyRequestData.data!.list![index].leaveStartDate!;
                                     stre = value.MyRequestData.data!.list![index].leaveEndDate!;

                                    if(str.length>0)
                                    {
                                      starttime = str.split(' ');
                                    }
                                    if(stre.length>0)
                                    {
                                      endtime = stre.split(' ');
                                    }


                                  }

                                  return value.MyRequestData.data!.list![index].request ==
                                      1
                                      ?
                                  GestureDetector(
                                    onTap: (){
                                      context.read<My_Request_ViewModel>().setRequestWorkFlow(value.MyRequestData.data!.list![index].requestNo!);
                                      context.read<My_Request_ViewModel>().setRequesteww3(value.MyRequestData.data!.list![index].request!);
                                      context.read<My_Request_ViewModel>().setDital1("1", value.MyRequestData.data!.list![index].vacStartDate!, value.MyRequestData.data!.list![index].vacEndDate!);

                                      Navigator.pushNamed(context, RoutesName.DitalsRequest_Screen);

                                    },
                                        child:
                                        Container(
                                          width: width,
                                          margin: EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(12)),
                                            border: Border.all(
                                              color: ColorTheme(context), // Border color
                                              width: 1.2, // Border width
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: width * 0.30,
                                                child:  Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    textWidget(formatter.format(int.parse(StartDay!)).toString(), 33/sc, FontWeight.w800, ColorTheme(context)),
                                                    const SizedBox(width: 5),
                                                    Column(
                                                      children: [
                                                        textWidget(months[int.parse(StartMonth!)-1], 15/sc, FontWeight.w900, Colors.black),
                                                        textWidget(StartYear! , 15/sc, FontWeight.w500, Colors.black),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              textWidget("-", 20, FontWeight.w800, Colors.black),
                                              SizedBox(
                                                width: width * 0.30,
                                                child:  Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    textWidget(formatter.format(int.parse(EndDay!)).toString(), 33/sc, FontWeight.w800, ColorTheme(context)),
                                                    const SizedBox(width: 5),
                                                    Column(
                                                      children: [
                                                        textWidget(months[int.parse(EndMonth!)-1] , 15/sc, FontWeight.w900, Colors.black),
                                                        textWidget(EndYear! , 15/sc, FontWeight.w500, Colors.black),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: (width * 0.10),
                                            child: SvgPicture.asset(
                                              "assest/vacman.svg",
                                              semanticsLabel: 'Acme sLogo',
                                              color: value.MyRequestData.data!.list![index].requestAction==5?Colors.grey:
                                              value.MyRequestData.data!.list![index].requestAction==1?Colors.green:Colors.red,
                                              width:
                                              MediaQuery.sizeOf(context)
                                                  .height /
                                                  20,
                                              height:
                                              MediaQuery.sizeOf(context)
                                                  .height /
                                                  20,
                                              fit: BoxFit.contain,

                                            ),
                                          ),

                                            ],
                                          ),
                                        ),
                                      )
                                      :
                                  GestureDetector(
                                      onTap: (){
                                        context.read<My_Request_ViewModel>().setRequestWorkFlow(value.MyRequestData.data!.list![index].requestNo!);
                                        context.read<My_Request_ViewModel>().setRequesteww3(value.MyRequestData.data!.list![index].request!);
                                       // context.read<My_Request_ViewModel>().setDital2("1", value.MyRequestData.data!.list![index].vacStartDate!, value.MyRequestData.data!.list![index].vacEndDate!)

                                        context.read<My_Request_ViewModel>().setDital2("2", value.MyRequestData.data!.list![index].leaveStartDate!, value.MyRequestData.data!.list![index].leaveEndDate!,value.MyRequestData.data!.list![index].leaveDate!);

                                        Navigator.pushNamed(context, RoutesName.DitalsRequest_Screen);
                                      },
                                        child:
                                        Container(
                                          width: width,
                                          margin: EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(12)),
                                            border: Border.all(
                                              color: ColorTheme(context), // Border color
                                              width: 1.2, // Border width
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: (width * 0.20),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    textWidget(str.length>0?starttime[0].trim():"", 16/sc, FontWeight.w800,
                                                        ColorTheme(context)),
                                                    textWidget(str.length>0?starttime[1].trim():"", 26/sc, FontWeight.w800,
                                                        ColorTheme(context)),
                                                    /*  Row(
                                                        children: [
                                                          textWidget(stre.length>0?endtime[0].trim():"", 10,
                                                              FontWeight.w500, Colors.black),
                                                          textWidget(stre.length>0?endtime[1].trim():"", 10, FontWeight.w500,
                                                              appColor),
                                                        ],
                                                      )*/
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: (width * 0.20),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    textWidget(stre.length>0?endtime[0].trim():"", 16/sc, FontWeight.w800,
                                                        ColorTheme(context)),
                                                    textWidget(stre.length>0?endtime[1].trim():"", 26/sc, FontWeight.w800,
                                                        ColorTheme(context)),
                                                    /*  Row(
                                                        children: [
                                                          textWidget(stre.length>0?endtime[0].trim():"", 10,
                                                              FontWeight.w500, Colors.black),
                                                          textWidget(stre.length>0?endtime[1].trim():"", 10, FontWeight.w500,
                                                              appColor),
                                                        ],
                                                      )*/
                                                  ],
                                                ),
                                              ),
                                              textWidget("-", 20, FontWeight.w800, Colors.black),
                                              SizedBox(
                                                width: width * 0.30,
                                                child:  Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    textWidget(formatter.format(int.parse(LeaveDay!)).toString(), 33/sc, FontWeight.w800, ColorTheme(context)),
                                                    const SizedBox(width: 5),
                                                    Column(
                                                      children: [
                                                        textWidget(months[int.parse(LeaveMonth!)-1], 15/sc, FontWeight.w900, Colors.black),
                                                        textWidget(LeaveYear! , 15/sc, FontWeight.w500, Colors.black),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: (width * 0.10),
                                                child: SvgPicture.asset(
                                                  "assest/Leaveman.svg",
                                                  semanticsLabel: 'Acme sLogo',
                                                  color: value.MyRequestData.data!.list![index].requestAction==5?Colors.grey:
                                                  value.MyRequestData.data!.list![index].requestAction==1?Colors.green:Colors.red,
                                                  width:
                                                  MediaQuery.sizeOf(context)
                                                      .height /
                                                      20,
                                                  height:
                                                  MediaQuery.sizeOf(context)
                                                      .height /
                                                      20,
                                                  fit: BoxFit.contain,

                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      );
                                }):
                            Center(child: AutoSizeText("no data"),);
                        }
                        return Container();
                      }),
                    ),
                  ],
                ),
            ),
          ),
        ),
            )),
      ),
    );
  }

  void CalDayNumber(int flag) {
    if (flag == 1) {
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      _Enddate.text = currentDate;
      _Startdate.text = currentDate;
    } else {
      Map data = {
        "EmployeeNo": context.read<AuthViewModel>().UserName,
        "VacatiosType":
            context.read<Vacationsviewmodel>().VacationsShowType == 0
                ? 1
                : context.read<Vacationsviewmodel>().VacationsShowType,
        "StartDate": _Startdate.text.toString(),
        "EndDate": _Enddate.text.toString(),
      };

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final viewModel = context.read<Vacationsviewmodel>();
        viewModel.fetchVacationsData(data, context);
      });
    }
  }

    void Clear() {
    context.read<Vacationsviewmodel>().setVacationsTypeName("");
    context.read<Vacationsviewmodel>().setEmpalternative(0, "");
    context.read<Vacationsviewmodel>().setVacationsShowType(0);
  }
}
