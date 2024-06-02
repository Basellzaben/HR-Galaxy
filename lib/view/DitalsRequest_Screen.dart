// ignore_for_file: camel_case_types, library_private_types_in_public_api, non_constant_identifier_names, deprecated_member_use, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';
import 'package:provider/provider.dart';
import '../Dialogs/ShowImageDialog.dart';
import '../res/components/constants.dart';
import '../view_model/Home/HomeNew_View_Model.dart';
import '../view_model/MyRequest_View_Model/My_Request_ViewModel.dart';
import '../view_model/Vacations/Vacations_view_model.dart';

class DitalsRequest_Screen extends StatefulWidget {
  const DitalsRequest_Screen({Key? key}) : super(key: key);

  @override
  _DitalsRequest_ScreenState createState() => _DitalsRequest_ScreenState();
}

class _DitalsRequest_ScreenState extends State<DitalsRequest_Screen> {
  My_Request_ViewModel vacationsviewmodel = My_Request_ViewModel();
  Vacationsviewmodel Vacationsviewmodel1 = Vacationsviewmodel();
  @override
  void initState() {

    Map data = {
      "EmployeeNo": context.read<AuthViewModel>().UserName,
      "ActionNo": -1,
      "vac_type": context.read<My_Request_ViewModel>().RequestNo != 0
          ? context.read<My_Request_ViewModel>().RequestNo
          : -1,
      "WFReqType": context.read<My_Request_ViewModel>().RequestType != 0
          ? context.read<My_Request_ViewModel>().RequestType
          : -1,
      "ID": context.read<My_Request_ViewModel>().RequestWorkFlow,
    };
    Map data2 = {
      "ID": context.read<My_Request_ViewModel>().RequestWorkFlow,
      "WFRequestID": context.read<My_Request_ViewModel>().Requesteww3,
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<My_Request_ViewModel>();
      viewModel.fetchMyRequestDatadetails(data, context);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel2 = context.read<Vacationsviewmodel>();
      viewModel2.fetchGetApprovalHiostry(data2, context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double sc = MediaQuery.of(context).textScaleFactor;
    final ViewMode = Provider.of<HomeNewViewModel>(context);
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.MyRequestScreen,
                (Route<dynamic> route) => false);

        return false;
      },
      child: Directionality(
        textDirection: LanguageProvider.getDirection(),
        child: Scaffold(
            backgroundColor: ColorTheme(context),
            body: SafeArea(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
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
                      child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assest/request.png",
                                      width: 45,
                                      height: 45,
                                      color: ColorTheme(context),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.025,
                                    ),
                                    textWidget(
                                        LanguageProvider.Llanguage('myreqD'),
                                        20 / sc,
                                        FontWeight.w500,
                                        Colors.black)
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 0),
                                alignment: Alignment.topLeft,
                                child: InkWell(
                                  onTap: () {
                                    //   Navigator.pushNamed(context, RoutesName.homeHR);
                                    //   Navigator.pop(context);
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RoutesName.homeHR,
                                        (Route<dynamic> route) => false);
                                  },
                                  child: RotatedBox(
                                    quarterTurns:
                                        LanguageProvider.getLanguage() == "AR"
                                            ? 2
                                            : 2,
                                    child: Icon(
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
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                          child: Consumer<My_Request_ViewModel>(
                              builder: (context, value, _) {
                            switch (value.MyRequestDatadetails.status) {
                              case Status.LOADING:
                                return const Center(
                                    child: CircularProgressIndicator());
                              case Status.ERROR:
                                return Center(
                                    child: Text(value
                                        .MyRequestDatadetails.message
                                        .toString()));
                              case Status.COMPLETED:
                                late String? StartYear="",StartMonth="",StartDay="";
                                late String? EndYear="",EndMonth="",EndDay="";
                                late String? LeaveYear="",LeaveMonth="",LeaveDay="";
                                NumberFormat formatter = NumberFormat("00");
                                late String? TimeStart="",TimeEnd="";
                                List months = ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];
                                var starttime;
                                var endtime;
                                var str ;
                                var stre ;
                                var Leavedate;
                                if(  context.read<My_Request_ViewModel>().TypeRequset=="1")
                                {
                                  var startDate = DateFormat('yyyy-MM-dd').parse(context.read<My_Request_ViewModel>().StartDate);
                                  var endDate = DateFormat('yyyy-MM-dd').parse(context.read<My_Request_ViewModel>().EndDate);

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

                                  Leavedate = DateFormat('yyyy-MM-dd').parse(context.read<My_Request_ViewModel>().StartDate);
                                  LeaveYear = Leavedate.year.toString();
                                  LeaveMonth = Leavedate.month.toString();
                                  LeaveDay = Leavedate.day.toString();

                                  str = context.read<My_Request_ViewModel>().StartTime;
                                  stre = context.read<My_Request_ViewModel>().EndTime;

                                  if(str.length>0)
                                  {
                                    starttime = str.split(' ');
                                  }
                                  if(stre.length>0)
                                  {
                                    endtime = stre.split(' ');
                                  }


                                }
                                var date = DateFormat('yyyy-MM-dd').parse(value
                                    .MyRequestDatadetails
                                    .data!
                                    .list![0]
                                    .requestDate!);
                                return Column(children: [
                                  SizedBox(
                                    height: height * 0.02,
                                  ),

                                  // here start
                                  Container(
                                    width: width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      border: Border.all(
                                        color: ColorTheme(context), // Border color
                                        width: 1.2, // Border width
                                      ),
                                    ),
                                    child: textWidget(

                                            context.read<AuthViewModel>().Name,
                                        14,
                                        FontWeight.w500,
                                        Colors.black),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Container(
                                    width: width,
                                    margin: const EdgeInsets.only(bottom: 10),
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
                                    child: context.read<My_Request_ViewModel>().TypeRequset=="1"?Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: width * 0.28,
                                          child:  Row(
                                            children: [
                                              textWidget(formatter.format(int.parse(StartDay)).toString(), 35/sc, FontWeight.w800, ColorTheme(context)),
                                              const SizedBox(width: 5),
                                              Column(
                                                children: [
                                                  textWidget(months[int.parse(StartMonth)-1], 16/sc, FontWeight.w900, Colors.black),
                                                  textWidget(StartYear , 16/sc, FontWeight.w500, Colors.black),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        textWidget("-", 15, FontWeight.w800, Colors.black),
                                        SizedBox(
                                          width: width * 0.28,
                                          child:  Row(
                                            children: [
                                              textWidget(formatter.format(int.parse(EndDay)).toString(), 35/sc, FontWeight.w800, ColorTheme(context)),
                                              const SizedBox(width: 5),
                                              Column(
                                                children: [
                                                  textWidget(months[int.parse(EndMonth)-1] , 16/sc, FontWeight.w900, Colors.black),
                                                  textWidget(EndYear , 16/sc, FontWeight.w500, Colors.black),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          "assest/vacman.svg",
                                          semanticsLabel: 'Acme sLogo',
                                          color: value.MyRequestDatadetails.data!
                                              .list![0].requestAction ==5?Colors.grey:
                                          value.MyRequestDatadetails.data!
                                              .list![0].requestAction ==1?Colors.green:Colors.red,
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
                                    ): Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: (width * 0.28)/2,
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
                                          width: (width * 0.28)/2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              textWidget(stre.length>0?endtime[0].trim():"", 18/sc, FontWeight.w800,
                                                  ColorTheme(context)),
                                              textWidget(stre.length>0?endtime[1].trim():"", 28/sc, FontWeight.w800,
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
                                          width: width * 0.28,
                                          child:  Row(
                                            children: [
                                              textWidget(formatter.format(int.parse(LeaveDay)).toString(), 35/sc, FontWeight.w800, ColorTheme(context)),
                                              const SizedBox(width: 5),
                                              Column(
                                                children: [
                                                  textWidget(months[int.parse(LeaveMonth)-1], 16/sc, FontWeight.w900, Colors.black),
                                                  textWidget(LeaveYear , 16/sc, FontWeight.w500, Colors.black),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          "assest/Leaveman.svg",
                                          semanticsLabel: 'Acme sLogo',
                                          color: value.MyRequestDatadetails.data!
                                              .list![0].requestAction ==5?Colors.grey:
                                          value.MyRequestDatadetails.data!
                                              .list![0].requestAction ==1?Colors.green:Colors.red,
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
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          textWidget("${LanguageProvider.Llanguage('reqstatus2')}: " , 13,
                                              FontWeight.w500, ColorTheme(context)),
                                          textWidget(     value.MyRequestDatadetails.data!
                                              .list![0].requestAction ==
                                              5
                                              ? LanguageProvider.Llanguage('new')
                                              : value.MyRequestDatadetails.data!
                                              .list![0].requestAction  ==
                                              1
                                              ? LanguageProvider.Llanguage(
                                              'acceptable')
                                              : LanguageProvider.Llanguage(
                                              'rejected'), 13,
                                              FontWeight.w500, Colors.black),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          textWidget( '${LanguageProvider.Llanguage('requesttype2')}: ', 13,
                                              FontWeight.w500, ColorTheme(context)),
                                          textWidget(   LanguageProvider.getLanguage() == 'AR'
                                              ? value.MyRequestDatadetails.data!.list![0]
                                              .requestNameArabic!
                                              : value.MyRequestDatadetails.data!.list![0]
                                              .requestNameEn!, 13,
                                              FontWeight.w500, Colors.black),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  SizedBox( height: height * 0.05,child: fadedLine(LanguageProvider.Llanguage('notes'), 22 / sc,context)),

                                  SizedBox(
                                    height: height * 0.02,
                                  ),

                                  Container(
                                    width: width,
                                    height: height * 0.13,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      border: Border.all(
                                        color: ColorTheme(context), // Border color
                                        width: 1.2, // Border width
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(12.0),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: textWidget(
                                              value.MyRequestDatadetails.data!.list![0].request ==
                                                  1
                                                  ? value.MyRequestDatadetails.data!.list![0]
                                                  .vNotes!
                                                  : value.MyRequestDatadetails.data!.list![0]
                                                  .lNotes!,
                                              14,
                                              FontWeight.w500,
                                              Colors.black),
                                        ),

                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  InkWell(
                                      onTap: ()async {
                                        Map data = {
                                          'empNo': context
                                              .read<AuthViewModel>()
                                              .UserName,
                                          'actionNo':("${context.read<My_Request_ViewModel>().RequestWorkFlow}"),
                                          'coor_X': "0",
                                          'coor_Y': "0",
                                          'tabletName':
                                          ("${context.read<My_Request_ViewModel>().Requesteww3}"),
                                        };

                                    
                                      await ViewMode.set_deleteReq(data, context);
                                      

                                        
                                      },
                                      child: buttonBg(width, 50, LanguageProvider.Llanguage(
                                          'delete'),context)),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return WillPopScope(
                                                  onWillPop: () async {

                                                    return true;
                                                  },
                                                  child: const ShowImageDialog());
                                            }).then((value) {





                                        });
                                      },
                                      child: buttonBg(width, 50, LanguageProvider.Llanguage(
                                          'Image'),context)),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  SizedBox( height: height * 0.05,child: fadedLine(LanguageProvider.Llanguage('history'), 22 / sc,context)),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),

                                /*  Container(
                                    height: MediaQuery.of(context).size.height/2,
                                    child: Consumer<Vacationsviewmodel>(
                                        builder: (context, value, _) {
                                      switch (value.GetApprovalH.status) {
                                        case Status.LOADING:
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        case Status.ERROR:
                                          return Center(
                                              child: Text(value
                                                  .GetApprovalH.message
                                                  .toString()));
                                        case Status.COMPLETED:
                                          ListView.builder(
                                            itemCount:
                                                value.GetApprovalH.data!.list ==
                                                        null
                                                    ? 0
                                                    : value.GetApprovalH.data!
                                                        .list!.length,
                                            itemBuilder: (context, index) {
                                              var date =
                                                  DateFormat('yyyy-MM-dd')
                                                      .parse(value
                                                          .GetApprovalH
                                                          .data!
                                                          .list![index]
                                                          .wdate!);
                                              return Container(
                                                width: width,
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 12),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12)),
                                                  border: Border.all(
                                                    color:
                                                        appColor, // Border color
                                                    width: 1.2, // Border width
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: width * 0.6,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          textWidget(
                                                              "Muhammad Abdullah Alahmad",
                                                              13,
                                                              FontWeight.w500,
                                                              Colors.black),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          textWidget(
                                                              "Manager",
                                                              13,
                                                              FontWeight.w600,
                                                              appColor),
                                                        ],
                                                      ),
                                                    ),
                                                    if (index % 2 == 0)
                                                      Image.asset(
                                                        "assets/tick.png",
                                                        width: 35,
                                                        height: 35,
                                                      ),
                                                    if (index % 2 != 0)
                                                      Image.asset(
                                                        "assets/cross.png",
                                                        width: 35,
                                                        height: 35,
                                                      )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                      }
                                      return Container();
                                    }),
                                  ),*/

                                  SizedBox(
                                      height: MediaQuery.of(context).size.height/2,
                                      child: Consumer<Vacationsviewmodel>(
                                        builder: (context, value, _) {
                                          switch (value.GetApprovalH.status) {
                                            case Status.LOADING:
                                              return const Center(
                                                  child: CircularProgressIndicator());
                                            case Status.ERROR:
                                              return Center(
                                                  child: Text(value.GetApprovalH.message
                                                      .toString()));
                                            case Status.COMPLETED:

                                              return
                                                ListView.builder(
                                                    itemCount:
                                                    value.GetApprovalH.data!.list ==
                                                        null
                                                        ? 0
                                                        : value.GetApprovalH.data!
                                                        .list!.length,
                                                    itemBuilder: (context, index) {
                                                      var date = DateFormat('yyyy-MM-dd')
                                                          .parse(value
                                                          .GetApprovalH
                                                          .data!
                                                          .list![index]
                                                          .wdate!);
                                                      return Container(
                                                        width: width,
                                                        margin: const EdgeInsets.only(bottom: 10),
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 12, vertical: 12),
                                                        decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                                                          border: Border.all(
                                                            color: ColorTheme(context), // Border color
                                                            width: 1.2, // Border width
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width: width * 0.6,
                                                              child:  Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  textWidget(    LanguageProvider.getLanguage()=="AR"? value
                                                                      .GetApprovalH
                                                                      .data!
                                                                      .list![index]
                                                                      .userLName!:value
                                                                      .GetApprovalH
                                                                      .data!
                                                                      .list![index]
                                                                      .userFName!, 23/sc, FontWeight.w500, Colors.black),
                                                                  const SizedBox(height: 4,),
                                                                  textWidget(     LanguageProvider.getLanguage()=="AR"? value
                                                                      .GetApprovalH
                                                                      .data!
                                                                      .list![index]
                                                                      .jobDesc!:value
                                                                      .GetApprovalH
                                                                      .data!
                                                                      .list![index]
                                                                      .jobDescEN!,23/sc, FontWeight.w600, ColorTheme(context)),
                                                                  const SizedBox(height: 4,),
                                                                  textWidget(
                                                                      value
                                                                          .GetApprovalH
                                                                          .data!
                                                                          .list![index]
                                                                          .note!,18/sc, FontWeight.w600, Colors.black),
                                                                ],
                                                              ),
                                                            ),

                                                            Container(
                                                              width: MediaQuery.of(context).size.width/15,
                                                              alignment: Alignment.topCenter,
                                                              child: value.GetApprovalH.data!.list![index]
                                                                  .actionNo ==
                                                                  1
                                                                  ?  const Icon( Icons.check_circle_outline,color: Colors.green,size: 30)
                                                                  : value.GetApprovalH.data!.list![index].actionNo ==
                                                                  2
                                                                  ? const Icon( Icons.error_outline_outlined,
                                                                  color: Colors.red,size: 30)
                                                                  : const Icon( Icons.timer_outlined,color: Colors.grey,size: 30,),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                            case null:
                                              break;
                                          }
                                          return Container();
                                        },
                                      )),
                                ]);
                              case null:
                                break;
                            }
                            return Container();
                          }),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            )),
      ),
    );
  }
}
