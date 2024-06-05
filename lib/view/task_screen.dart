import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mvvm/Dialogs/DitalsTask_Dialog.dart';
import 'package:mvvm/Dialogs/RequestType_Dialog.dart';
import 'package:mvvm/Dialogs/Request_Dialog.dart';

import 'package:mvvm/data/response/status.dart';

import 'package:mvvm/res/components/round_button.dart';

import 'package:mvvm/view_model/MyRequest_View_Model/My_Request_ViewModel.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';
import 'package:provider/provider.dart';
import '../res/components/constants.dart';
import '../utils/routes/routes_name.dart';

class task_screen extends StatefulWidget {
  const task_screen({Key? key}) : super(key: key);

  @override
  _task_screenState createState() => _task_screenState();
}

class _task_screenState extends State<task_screen> {
  My_Request_ViewModel my_Request_ViewModel = My_Request_ViewModel();
  TextEditingController _Startdate = TextEditingController();
  TextEditingController _Enddate = TextEditingController();
  TextEditingController _RequestType = TextEditingController();
  var datess="";
  TextEditingController _VacationsType = TextEditingController();
  TextEditingController _Requst = TextEditingController();
  TextEditingController _EmpName = TextEditingController();
  TextEditingController _AlternateEmployee = TextEditingController();
  final DateFormat format1 = DateFormat('MMM');
  late String? StartYear = "", StartMonth = "", StartDay = "";
  late String? EndYear = "", EndMonth = "", EndDay = "";
  late String? LeaveYear = "", LeaveMonth = "", LeaveDay = "";
  late String? TimeStart = "", TimeEnd = "";
  List months = ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];


  late DateTime startDateTime;
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
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ViewMode = Provider.of<Vacationsviewmodel>(context);
    double sc = MediaQuery.of(context).textScaleFactor;
    double width = MediaQuery.of(context).size.width;

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
                                        LanguageProvider.Llanguage('task'), 25/sc, FontWeight.w500, Colors.black)
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                          child: RoundButton(
                            title:  LanguageProvider.Llanguage(
                                'sendrequest'),
                            loading: false,
                            fontSize: 20/MediaQuery.of(context).textScaleFactor,
                            onPress: () {
                              Map data = {
                                "EmployeeNo": context.read<AuthViewModel>().UserName,
                                "ActionNo": -1,
                                "vac_type":
                                    context.read<My_Request_ViewModel>().RequestNo != 0
                                        ? context.read<My_Request_ViewModel>().RequestNo
                                        : -1,
                                "WFReqType":
                                    context.read<My_Request_ViewModel>().RequestType != 0
                                        ? context.read<My_Request_ViewModel>().RequestType
                                        : -1,
                                "ID": 0,
                              };

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                final viewModel = context.read<My_Request_ViewModel>();
                                viewModel.fetchTaskData(data, context);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0, left: 15, right: 15),
                      height: MediaQuery.sizeOf(context).height /1.5,
                      // ,
                      child: Consumer<My_Request_ViewModel>(builder: (context, value, _) {
                        switch (value.TaskData.status) {
                          case Status.LOADING:
                            return Center(child: CircularProgressIndicator());
                          case Status.ERROR:
                            return Center(child: Text(value.TaskData.message.toString()));
                          case Status.COMPLETED:
                            return value.TaskData.data!.list != null
                                ?
                            ListView.builder(
                                    itemCount: value.TaskData.data!.list!.length,
                                    //   physics: const AlwaysScrollableScrollPhysics(), // new
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var starttime;
                                      var endtime;
                                      var str ;
                                      var stre ;
                                      var Leavedate;
                                      if (int.parse(value.TaskData.data!.list![index]
                                          .wfRequestID!) ==
                                          1)
                                      {
                                        var startDate = DateFormat('yyyy-MM-dd').parse(
                                            value.TaskData.data!.list![index]
                                                .vacStartDate!);
                                        var endDate = DateFormat('yyyy-MM-dd').parse(value
                                            .TaskData.data!.list![index].vacEndDate!);
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
                                         Leavedate = DateFormat('yyyy-MM-dd').parse(
                                            value.TaskData.data!.list![index].leaveDate!);
                                    //    Leavedate = DateFormat('yyyy-MM-dd').parse(value.MyRequestData.data!.list![index].leaveDate!);
                                        LeaveYear = Leavedate.year.toString();
                                        LeaveMonth = Leavedate.month.toString();
                                        LeaveDay = Leavedate.day.toString();

                                        str = value.TaskData.data!.list![index].leaveStartDate!;
                                        stre = value.TaskData.data!.list![index].leaveEndDate!;

                                        if(str.length>0)
                                        {
                                          starttime = str.split(' ');
                                        }
                                        if(stre.length>0)
                                        {
                                          endtime = stre.split(' ');
                                        }


                                      }
                                      //////////////////////////////////////////////////

                          /*            if (int.parse(value.TaskData.data!.list![index]
                                              .wfRequestID!) ==
                                          1) {
                                        var startDate = DateFormat('yyyy-MM-dd').parse(
                                            value.TaskData.data!.list![index]
                                                .vacStartDate!);
                                        var endDate = DateFormat('yyyy-MM-dd').parse(value
                                            .TaskData.data!.list![index].vacEndDate!);

                                        StartYear = startDate.year.toString();
                                        StartMonth = startDate.month.toString();
                                        StartDay = startDate.day.toString();
                                        //  print(StartMonth!);

                                        EndYear = endDate.year.toString();
                                        EndMonth = endDate.month.toString();
                                        EndDay = endDate.day.toString();
                                      } else {
                                        var Leavedate = DateFormat('yyyy-MM-dd').parse(
                                            value.TaskData.data!.list![index].leaveDate!);
                                        LeaveYear = Leavedate.year.toString();
                                        LeaveMonth = Leavedate.month.toString();
                                        LeaveDay = Leavedate.day.toString();
                                         datess= "("+value.TaskData.data!.list![index].leaveStartDate!+" "+value.TaskData.data!.list![index].leaveEndDate!+")";

                                        print(LeaveDay! + "sasss");
                                      }*/

                                      return int.parse(value.TaskData.data!.list![index]
                                                  .wfRequestID!) ==
                                              1
                                          ?
                                  /*    GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<My_Request_ViewModel>()
                                                    .setRequestWorkFlow(int.parse(value
                                                        .TaskData
                                                        .data!
                                                        .list![index]
                                                        .workFlowID!));
                                                context.read<My_Request_ViewModel>()
                                                    .setRequesteww(int.parse(value
                                                        .TaskData
                                                        .data!
                                                        .list![index]
                                                        .wfRequestID!));
                                                Navigator.pushNamed(context, RoutesName.DitalsTask_Screen);
                                              */
                                      /*  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return WillPopScope(
                                                          onWillPop: () async {
                                                            return true;
                                                          },
                                                          child: DitalsTask_Dialog());
                                                    }).then((value) {
                                                  context
                                                      .read<My_Request_ViewModel>()
                                                      .setRequestWorkFlow(0);
                                                });*/
                                      /*
                                              },
                                              child: Card(
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(20)),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.sizeOf(context).width,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                                                      children: [
                                                        Container(
                                                          width: MediaQuery.sizeOf(context).width/5,

                                                          child: SvgPicture.asset(
                                                            "assest/vacman.svg",
                                                            semanticsLabel: 'Acme sLogo',
                                                            color: int.parse(value
                                                                        .TaskData
                                                                        .data!
                                                                        .list![index]
                                                                        .wfAction!) ==
                                                                    5
                                                                ? Colors.grey
                                                                : int.parse(value
                                                                            .TaskData
                                                                            .data!
                                                                            .list![index]
                                                                            .wfAction!) ==
                                                                        1
                                                                    ? Colors.green
                                                                    : Colors.red,
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
                                                        Container(
                                                          width: 3,
                                                          height: MediaQuery.sizeOf(context).height/5,
                                                          color: ColorTheme(context),
                                                        ),
                                                        Expanded(
                                                          child: Container(

                                                            child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                    margin: EdgeInsets.only(top: 10,right: 10,left: 10),
                                                                    child: Text(LanguageProvider.getLanguage()=="AR"?value
                                                                        .TaskData
                                                                        .data!
                                                                        .list![index]
                                                                        .reqEmp!:value
                                                                        .TaskData
                                                                        .data!
                                                                        .list![index]
                                                                        .reqEmpEN!,style: TextStyle(fontSize: 15),)),
                                                                Container(

                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        margin: EdgeInsets.only(right: 10,left: 10),

                                                                        child: Text(
                                                                            formatter
                                                                                .format(int.parse(
                                                                                    StartDay!))
                                                                                .toString(),
                                                                            style:
                                                                                ColorDayTask(context)),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Container(
                                                                        child: Text(
                                                                          months[int.parse(
                                                                                  StartMonth!) -
                                                                              1],
                                                                          style:
                                                                              ColorMonthTask(context),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Container(
                                                                          child: Text(
                                                                        StartYear!,
                                                                        style: ColorYearTask(context),
                                                                      )),
                                                                      SizedBox(width: 5,),

                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(

                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [

                                                                      Container(
                                                                        margin: EdgeInsets.only(right: 10,left: 10),
                                                                        child: Text(
                                                                            formatter
                                                                                .format(int.parse(
                                                                                EndDay!))
                                                                                .toString(),
                                                                            style:
                                                                            ColorDayTask(context)),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Container(
                                                                        child: Text(
                                                                          months[int.parse(
                                                                              EndMonth!) -
                                                                              1],
                                                                          style:
                                                                          ColorMonthTask(context),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Container(
                                                                          child: Text(
                                                                            EndYear!,
                                                                            style: ColorYearTask(context),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap: () {
                                                                        Map data = {
                                                                          "ID": int.parse(value
                                                                            .TaskData
                                                                            .data!
                                                                            .list![index]
                                                                            .workFlowID!),
                                                                          "WFRequestID": int.parse(value
                                                                              .TaskData
                                                                              .data!
                                                                              .list![index]
                                                                              .wfRequestID!),

                                                                          "ActionNo": 2,
                                                                        };

                                                                        WidgetsBinding
                                                                            .instance
                                                                            .addPostFrameCallback((_){
                                                                          //final   viewModel1 = context.read<Vacationsviewmodel>();
                                                                          ViewMode.SaveApproval(data,LanguageProvider.getLanguage(),context);}
                                                                        );
                                                                        if(context.read<Vacationsviewmodel>().chex ==1) {
                                                                          getdata();
                                                                        }                                                              },
                                                                      child: Container(
                                                                        child:
                                                                            SvgPicture.asset(
                                                                          "assest/cancel.svg",
                                                                          semanticsLabel:
                                                                              'Acme Logo',
                                                                          color: Colors.red,
                                                                          width: 45,
                                                                          height: 45,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    InkWell(
                                                                      onTap: (){
                                                                        Map data = {
                                                                          "ID": int.parse(value
                                                                              .TaskData
                                                                              .data!
                                                                              .list![index]
                                                                              .workFlowID!),
                                                                          "WFRequestID": int.parse(value
                                                                              .TaskData
                                                                              .data!
                                                                              .list![index]
                                                                              .wfRequestID!),

                                                                          "ActionNo": 1,
                                                                        };

                                                                        WidgetsBinding
                                                                            .instance
                                                                            .addPostFrameCallback((_){
                                                                          //final   viewModel1 = context.read<Vacationsviewmodel>();
                                                                          ViewMode.SaveApproval(data,LanguageProvider.getLanguage(),context);}
                                                                        );
                                                                        if(context.read<Vacationsviewmodel>().chex ==1) {
                                                                          getdata();
                                                                        }                                                              },
                                                                      child: SvgPicture.asset(
                                                                        "assest/check_circle.svg",
                                                                        semanticsLabel:
                                                                            'Acme Logo',
                                                                        color: Colors.green,
                                                                        width: 45,
                                                                        height: 45,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            ),*/
                                      GestureDetector(
                                        onTap: (){
                                          context
                                              .read<My_Request_ViewModel>()
                                              .setRequestWorkFlow(int.parse(value
                                              .TaskData
                                              .data!
                                              .list![index]
                                              .workFlowID!));
                                          context.read<My_Request_ViewModel>()
                                              .setRequesteww(int.parse(value
                                              .TaskData
                                              .data!
                                              .list![index]
                                              .wfRequestID!));

                                          context.read<My_Request_ViewModel>().setDital1("1", value.TaskData.data!.list![index].vacStartDate!, value.TaskData.data!.list![index].vacEndDate!);

                                          Navigator.pushNamed(context, RoutesName.DitalsTask_Screen);

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
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                  width: (width),
                                                  child: Text(LanguageProvider.getLanguage()=="AR"?value
                                                      .TaskData
                                                      .data!
                                                      .list![index]
                                                      .reqEmp!:value
                                                      .TaskData
                                                      .data!
                                                      .list![index]
                                                      .reqEmpEN!,style: TextStyle(fontSize: 25/sc),)
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.28,
                                                    child:  Row(
                                                      children: [
                                                        textWidget(formatter.format(int.parse(StartDay!)).toString(), 40/sc, FontWeight.w800, ColorTheme(context)),
                                                        const SizedBox(width: 5),
                                                        Column(
                                                          children: [
                                                            textWidget(months[int.parse(StartMonth!)-1], 18/sc, FontWeight.w900, Colors.black),
                                                            textWidget(StartYear! , 18/sc, FontWeight.w500, Colors.black),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  textWidget("-", 20, FontWeight.w800, Colors.black),
                                                  SizedBox(
                                                    width: width * 0.28,
                                                    child:  Row(
                                                      children: [
                                                        textWidget(formatter.format(int.parse(EndDay!)).toString(), 40/sc, FontWeight.w800, ColorTheme(context)),
                                                        const SizedBox(width: 5),
                                                        Column(
                                                          children: [
                                                            textWidget(months[int.parse(EndMonth!)-1] , 18/sc, FontWeight.w900, Colors.black),
                                                            textWidget(EndYear! , 18/sc, FontWeight.w500, Colors.black),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SvgPicture.asset(
                                                    "assest/vacman.svg",
                                                    semanticsLabel: 'Acme sLogo',
                                                    color: int.parse(value.TaskData.data!.list![index].wfAction!)==5?Colors.grey:
                                                    int.parse(value.TaskData.data!.list![index].wfAction!)==1?Colors.green:Colors.red,
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

                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Map data = {
                                                        "ID": int.parse(value
                                                            .TaskData
                                                            .data!
                                                            .list![index]
                                                            .workFlowID!),
                                                        "WFRequestID": int.parse(value
                                                            .TaskData
                                                            .data!
                                                            .list![index]
                                                            .wfRequestID!),

                                                        "ActionNo": 2,
                                                      };

                                                      WidgetsBinding
                                                          .instance
                                                          .addPostFrameCallback((_){
                                                        //final   viewModel1 = context.read<Vacationsviewmodel>();
                                                        ViewMode.SaveApproval(data,LanguageProvider.getLanguage(),context);}
                                                      );
                                                      if(context.read<Vacationsviewmodel>().chex ==1) {
                                                        getdata();
                                                      }                                                              },
                                                    child: Container(
                                                      child:
                                                      SvgPicture.asset(
                                                        "assest/cancel.svg",
                                                        semanticsLabel:
                                                        'Acme Logo',
                                                        color: Colors.red,
                                                        width: 45,
                                                        height: 45,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      Map data = {
                                                        "ID": int.parse(value
                                                            .TaskData
                                                            .data!
                                                            .list![index]
                                                            .workFlowID!),
                                                        "WFRequestID": int.parse(value
                                                            .TaskData
                                                            .data!
                                                            .list![index]
                                                            .wfRequestID!),

                                                        "ActionNo": 1,
                                                      };

                                                      WidgetsBinding
                                                          .instance
                                                          .addPostFrameCallback((_){
                                                        //final   viewModel1 = context.read<Vacationsviewmodel>();
                                                        ViewMode.SaveApproval(data,LanguageProvider.getLanguage(),context);}
                                                      );
                                                      if(context.read<Vacationsviewmodel>().chex ==1) {
                                                        getdata();
                                                      }                                                              },
                                                    child: SvgPicture.asset(
                                                      "assest/check_circle.svg",
                                                      semanticsLabel:
                                                      'Acme Logo',
                                                      color: Colors.green,
                                                      width: 45,
                                                      height: 45,
                                                    ),
                                                  ),
                                                ],


                                          ),
                                            ],

                                          ),
                                        ),
                                      )
                                          :
                             /*         GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<My_Request_ViewModel>()
                                                    .setRequestWorkFlow(int.parse(value
                                                        .TaskData
                                                        .data!
                                                        .list![index]
                                                        .workFlowID!));
                                                context.read<My_Request_ViewModel>()
                                                    .setRequesteww(int.parse(value
                                                    .TaskData
                                                    .data!
                                                    .list![index]
                                                    .wfRequestID!));
                                                Navigator.pushNamed(context, RoutesName.DitalsTask_Screen);
                                           *//*     showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return WillPopScope(
                                                          onWillPop: () async {
                                                            return true;
                                                          },
                                                          child: DitalsTask_Dialog());
                                                    }).then((value) {
                                                  context
                                                      .read<My_Request_ViewModel>()
                                                      .setRequestWorkFlow(0);
                                                });*//*
                                              },
                                              child: Card(
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(20)),


                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(context).width/5,

                                                      child: SvgPicture.asset(
                                                          "assest/Leaveman.svg",
                                                        semanticsLabel: 'Acme sLogo',
                                                        color: int.parse(value
                                                            .TaskData
                                                            .data!
                                                            .list![index]
                                                            .wfAction!) ==
                                                            5
                                                            ? Colors.grey
                                                            : int.parse(value
                                                            .TaskData
                                                            .data!
                                                            .list![index]
                                                            .wfAction!) ==
                                                            1
                                                            ? Colors.green
                                                            : Colors.red,
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
                                                    Container(
                                                      width: 3,
                                                      height: MediaQuery.sizeOf(context).height/5,
                                                      color: ColorTheme(context),
                                                    ),
                                                    Expanded(
                                                      child: Container(

                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                                margin: EdgeInsets.only(
                                                                    top: 10,left: 10,right: 10),
                                                                child: Text(LanguageProvider.getLanguage()=="AR"?value
                                                                    .TaskData
                                                                    .data!
                                                                    .list![index]
                                                                    .reqEmp!:value
                                                                    .TaskData
                                                                    .data!
                                                                    .list![index]
                                                                    .reqEmpEN!,style: TextStyle(fontSize: 15),)),
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                  top: 0,left: 10,right: 10),
                                                              child: Row(

                                                                children: [
                                                                  Container(

                                                                    child: Text(
                                                                        formatter
                                                                            .format(int.parse(
                                                                            LeaveDay!))
                                                                            .toString(),
                                                                        style:
                                                                        ColorDayTask(context)),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      months[int.parse(
                                                                          LeaveMonth!) -
                                                                          1],
                                                                      style:
                                                                      ColorMonthTask(context),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),  Container(
                                                                      child: Text(
                                                                        LeaveYear!,
                                                                        style: ColorYearTask(context),
                                                                      )),

                                                                ],
                                                              ),
                                                            ),
                                                            Container(


                                                              margin: EdgeInsets.only(
                                                                  top: 0,left: 10,right: 10),

                                                                child: AutoSizeText(datess.toString(),style: ColorBlack5(context) ,),

                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    print( value
                                                                        .TaskData
                                                                        .data!
                                                                        .list![index]
                                                                        .workFlowID!);
                                                                    Map data = {
                                                                      "ID": int.parse(value
                                                                          .TaskData
                                                                          .data!
                                                                          .list![index]
                                                                          .workFlowID!),
                                                                      "WFRequestID": int.parse(value
                                                                          .TaskData
                                                                          .data!
                                                                          .list![index]
                                                                          .wfRequestID!),

                                                                      "ActionNo": 2,
                                                                    };

                                                                    WidgetsBinding
                                                                        .instance
                                                                        .addPostFrameCallback((_){
                                                                      //final   viewModel1 = context.read<Vacationsviewmodel>();
                                                                      ViewMode.SaveApproval(data,LanguageProvider.getLanguage(),context);}
                                                                    );
                                                                    if(context.read<Vacationsviewmodel>().chex ==1) {
                                                                      getdata();
                                                                    }                                                          },
                                                                  child: Container(
                                                                    child:
                                                                    SvgPicture.asset(
                                                                      "assest/cancel.svg",
                                                                      semanticsLabel:
                                                                      'Acme Logo',
                                                                      color: Colors.red,
                                                                      width: 45,
                                                                      height: 45,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                InkWell(
                                                                  onTap: (){
                                                                    Map data = {
                                                                      "ID": int.parse(value
                                                                          .TaskData
                                                                          .data!
                                                                          .list![index]
                                                                          .workFlowID!),
                                                                      "WFRequestID": int.parse(value
                                                                          .TaskData
                                                                          .data!
                                                                          .list![index]
                                                                          .wfRequestID!),

                                                                      "ActionNo": 1,
                                                                    };

                                                                    WidgetsBinding
                                                                        .instance
                                                                        .addPostFrameCallback((_){
                                                                      //final   viewModel1 = context.read<Vacationsviewmodel>();
                                                                      ViewMode.SaveApproval(data,LanguageProvider.getLanguage(),context);}
                                                                    );

                                                                  *//*  if(context.read<Vacationsviewmodel>().chex ==1) {
                                                                      getdata();
                                                                    }*//*
                                                                  },
                                                                  child: SvgPicture.asset(
                                                                    "assest/check_circle.svg",
                                                                    semanticsLabel:
                                                                    'Acme Logo',
                                                                    color: Colors.green,
                                                                    width: 45,
                                                                    height: 45,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );*/
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<My_Request_ViewModel>()
                                              .setRequestWorkFlow(int.parse(value
                                              .TaskData
                                              .data!
                                              .list![index]
                                              .workFlowID!));
                                          context.read<My_Request_ViewModel>()
                                              .setRequesteww(int.parse(value
                                              .TaskData
                                              .data!
                                              .list![index]
                                              .wfRequestID!));
                                          context.read<My_Request_ViewModel>().setDital2("2", value.TaskData.data!.list![index].leaveStartDate!, value.TaskData.data!.list![index].leaveEndDate!,value.TaskData.data!.list![index].leaveDate!);

                                          Navigator.pushNamed(context, RoutesName.DitalsTask_Screen);


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
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: (width),
                                                  child: Text(LanguageProvider.getLanguage()=="AR"?value
                                                      .TaskData
                                                      .data!
                                                      .list![index]
                                                      .reqEmp!:value
                                                      .TaskData
                                                      .data!
                                                      .list![index]
                                                      .reqEmpEN!,style: TextStyle(fontSize: 25/sc),)
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width: (width * 0.20),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [

                                                        textWidget(str.length>0?starttime[0].trim():"", 17/sc, FontWeight.w800,
                                                            ColorTheme(context)),
                                                        textWidget(str.length>0?starttime[1].trim():"", 25/sc, FontWeight.w800,
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
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [

                                                        textWidget(stre.length>0?endtime[0].trim():"", 17/sc, FontWeight.w800,
                                                            ColorTheme(context)),
                                                        textWidget(stre.length>0?endtime[1].trim():"", 25/sc, FontWeight.w800,
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
                                                    width: (width * 0.05),
                                                    child:    textWidget("-", 20, FontWeight.w800, Colors.black),
                                                  ),
                                                  SizedBox(

                                                    width: width * 0.30,
                                                    child:  Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        textWidget(formatter.format(int.parse(LeaveDay!)).toString(), 30/sc, FontWeight.w800, ColorTheme(context)),
                                                        const SizedBox(width: 5),
                                                        Column(
                                                          children: [
                                                            textWidget(months[int.parse(LeaveMonth!)-1], 18/sc, FontWeight.w900, Colors.black),
                                                            textWidget(LeaveYear! , 18/sc, FontWeight.w500, Colors.black),
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
                                                      color: int.parse(value.TaskData.data!.list![index].wfAction!)==5?Colors.grey:
                                                      int.parse(value.TaskData.data!.list![index].wfAction!)==1?Colors.green:Colors.red,
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

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      print( value
                                                          .TaskData
                                                          .data!
                                                          .list![index]
                                                          .workFlowID!);
                                                      Map data = {
                                                        "ID": int.parse(value
                                                            .TaskData
                                                            .data!
                                                            .list![index]
                                                            .workFlowID!),
                                                        "WFRequestID": int.parse(value
                                                            .TaskData
                                                            .data!
                                                            .list![index]
                                                            .wfRequestID!),

                                                        "ActionNo": 2,
                                                      };

                                                      WidgetsBinding
                                                          .instance
                                                          .addPostFrameCallback((_){
                                                        //final   viewModel1 = context.read<Vacationsviewmodel>();
                                                        ViewMode.SaveApproval(data,LanguageProvider.getLanguage(),context);}
                                                      );
                                                      if(context.read<Vacationsviewmodel>().chex ==1) {
                                                        getdata();
                                                      }                                                          },
                                                    child: Container(
                                                      child:
                                                      SvgPicture.asset(
                                                        "assest/cancel.svg",
                                                        semanticsLabel:
                                                        'Acme Logo',
                                                        color: Colors.red,
                                                        width: 45,
                                                        height: 45,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      Map data = {
                                                        "ID": int.parse(value
                                                            .TaskData
                                                            .data!
                                                            .list![index]
                                                            .workFlowID!),
                                                        "WFRequestID": int.parse(value
                                                            .TaskData
                                                            .data!
                                                            .list![index]
                                                            .wfRequestID!),

                                                        "ActionNo": 1,
                                                      };

                                                      WidgetsBinding
                                                          .instance
                                                          .addPostFrameCallback((_){
                                                        //final   viewModel1 = context.read<Vacationsviewmodel>();
                                                        ViewMode.SaveApproval(data,LanguageProvider.getLanguage(),context);}
                                                      );


                                                    },
                                                    child: SvgPicture.asset(
                                                      "assest/check_circle.svg",
                                                      semanticsLabel:
                                                      'Acme Logo',
                                                      color: Colors.green,
                                                      width: 45,
                                                      height: 45,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],

                                          ),
                                        ),
                                      );
                                    })
                                : Center(
                                    child: Text("no data"),
                                  );
                          case null:
                            // TODO: Handle this case.
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

  void getdata() {

    Map data1 = {
      "EmployeeNo": context.read<AuthViewModel>().UserName,
      "ActionNo": -1,
      "vac_type": -1,
      "WFReqType": -1,
      "ID": 0,
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<My_Request_ViewModel>().setRequest(0, "");
      context.read<My_Request_ViewModel>().setRequestType(0, "");

      final viewModel = context.read<My_Request_ViewModel>();
      viewModel.fetchTaskData(data1, context);
    });
  }
}
