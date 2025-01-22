
// ignore_for_file: non_constant_identifier_names, deprecated_member_use, avoid_print, prefer_typing_uninitialized_variables

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/view_model/MyRequest_View_Model/My_Request_ViewModel.dart';
import 'package:mvvm/view_model/Profile/Profile_View_Model.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../res/components/constants.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/services/LanguagePrvider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  My_Request_ViewModel my_Request_ViewModel = My_Request_ViewModel();
  final TextEditingController _Startdate = TextEditingController();
  final TextEditingController _Enddate = TextEditingController();
  final TextEditingController _EmpName = TextEditingController();
  var state = false;

  late DateTime startDateTime;
  late DateTime endDateTime;
  NumberFormat formatter = NumberFormat("00");
  @override
  void initState() {
    // TODO: implement initState
    //homeViewViewModel.fetchMoviesListApi();
    /*   _EmpName.text=  context.read<AuthViewModel>().Name;
    print('AlertDialog dismissed ' +
        context.read<Vacationsviewmodel>().VacationsTypeName);
    _VacationsType.text = context.read<Vacationsviewmodel>().VacationsTypeName;
    CalDayNumber(1);*/
    CalDayNumber(1);
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    _EmpName.text = context.read<AuthViewModel>().Name;

    Map data = {
      "Emp_no": context.read<AuthViewModel>().UserName,
      "S_date": _Startdate.text,
      "E_date": _Enddate.text,
      "Lan": LanguageProvider.getLanguage()=="AR"?"Ar":"En",
    };



    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<ProfileViewModel>();
      viewModel.GetAttendancenew(data, context);



    });

    super.initState();
  }
  double width = 0;
  @override
  Widget build(BuildContext context) {
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    width = MediaQuery.of(context).size.width;
    double sc = MediaQuery.of(context).textScaleFactor;
    final
    List months = ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];
    late String? StartYear="",StartMonth="",StartDay="";
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
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child:
                          Row(
                    
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                    
                              Container(
                                padding: const EdgeInsets.only(left: 30, right: 30, top: 0),
                    
                                child:Row(
                                  children: [
                                    Image.asset(
                                      "assest/attendance.png",
                                      width: 45,
                                      height: 45,
                                      color: ColorTheme(context),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width * 0.025,
                                    ),
                                    textWidget(
                                        LanguageProvider.Llanguage('workingstate'), 25/sc, FontWeight.w500, Colors.black)
                                  ],
                                ),
                              )
                    
                     ,
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.only(left: 30, right: 30, top: 0),
                    
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
                    
                          margin: const EdgeInsets.only(left: 30, right: 30,top: 15),
                          child: Text(
                            LanguageProvider.Llanguage('emp'),
                            style: TextFormFieldColor(context),
                          ),
                        ),

// buttons
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SizedBox(
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width:
                                  MediaQuery.of(context).size.width / 2.1,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: state
                                          ? ColorTheme(context)
                                          : Colors.grey,
                                    ),
                                    child: Text(
                                      LanguageProvider.Llanguage('workingstateMap'),
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color:
                                         Colors.white,
                                          fontSize: 15 ),
                                    ),
                                    onPressed: () async {
                                      if (!state) {
                                        setState(() {
                                          state = true;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  height: 50,
                                  width:
                                  MediaQuery.of(context).size.width / 2.1,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: state
                                          ? Colors.grey
                                          : ColorTheme(context),
                                    ),
                                    child: Text(
                                      LanguageProvider.Llanguage('workingstate'),
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color:
                                          Colors.white,
                                          fontSize: 15 ),
                                    ),
                                    onPressed: () async {
                                      if (state) {
                                        setState(() {
                                          state = false;
                                        });
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        Container(
                    
                          margin: const EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: TextFormField(
                    
                            controller: _EmpName,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: ColorBlack3(context),
                            readOnly: true,
                            decoration: InputDecoration(
                              /*   prefixIcon: Icon(Icons.person),*/
                    
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 5.0),
                              labelStyle: ColorBlack3(context),
                              hintStyle: ColorBlack3(context),
                              suffixIcon: InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    size: 35,
                                    Icons.keyboard_arrow_down,
                                    color: ColorTheme(context),
                                  )),
                              focusedBorder: OutlineInputBorder(
                                borderSide: SBorderside(context),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: SBorderside(context),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 30 ,right: 30,top: 10),
                                  child: Text(
                                    LanguageProvider.Llanguage('fromdate'),
                                    style: TextFormFieldColor(context),
                                  ),
                                ),
                                Container(
                    
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 3 + 30,
                                  margin: const EdgeInsets.only(
                                      left: 15, right: 15, top: 5),
                                  child: TextFormField(
                    
                                    style: TextFormFieldColor3(context) ,
                                    onChanged: (text) {
                                      CalDayNumber(2);
                                    },
                    
                                    textAlign: TextAlign.center,
                                    controller: _Startdate,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      /*   prefixIcon: Icon(Icons.person),*/
                    
                                      suffixIcon: InkWell(
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                //DateTime.now() - not to allow to choose before today.
                                                lastDate: DateTime(2101));
                    
                                            if (pickedDate != null) {
                                              //pickedDate output format => 2021-03-10 00:00:00.000
                                              String formattedDate =
                                              DateFormat('yyyy-MM-dd').format(
                                                  pickedDate);
                                              print(
                                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                                              //you can implement different kind of Date Format here according to your requirement
                    
                                              setState(() {
                                                _Startdate.text = formattedDate;
                                              //  _Enddate.text =formattedDate;
                                                CalDayNumber(
                                                    2); //set output date to TextField value.
                                              });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                          child: Icon(
                                            size: 30,
                                            Icons.calendar_month_outlined,
                                            color: ColorBlue(),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: SBorderside(context),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: SBorderside(context),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 30 ,right: 30,top: 10),
                                  child: Text(
                                    LanguageProvider
                                        .Llanguage(
                                        'todate'),
                                    style: TextFormFieldColor(context),
                                  ),
                                ),
                                Container(

                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 3 + 30,
                                  margin: const EdgeInsets.only(
                                      left: 15, right: 15, top: 5),
                                  child: TextFormField(
                                    style: TextFormFieldColor3(context) ,
                                    onChanged: (text) {
                                      CalDayNumber(2);
                                    },
                                    textAlign: TextAlign.center,
                                    controller: _Enddate,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      /*   prefixIcon: Icon(Icons.person),*/
                                      labelStyle: ColorBlack(context),
                                      hintStyle: ColorBlack(context),
                                      suffixIcon: InkWell(
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                //DateTime.now() - not to allow to choose before today.
                                                lastDate: DateTime(2101));
                    
                                            if (pickedDate != null) {
                                              print(
                                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                              String formattedDate =
                                              DateFormat('yyyy-MM-dd').format(
                                                  pickedDate);
                                              print(
                                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                                              //you can implement different kind of Date Format here according to your requirement
                    
                                              setState(() {
                                                _Enddate.text = formattedDate;
                                                CalDayNumber(
                                                    2); //set output date to TextField value.
                                              });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                          child: Icon(
                                            size: 30,
                                            Icons.calendar_month_outlined,
                                            color: ColorBlue(),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: SBorderside(context),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: SBorderside(context),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                          child: RoundButton(
                            title:  LanguageProvider.Llanguage(
                                'sendrequest'),
                            loading: false,
                            fontSize: 20/MediaQuery.of(context).textScaleFactor,
                            onPress: () {
                              Map data = {
                              "Emp_no": context.read<AuthViewModel>().UserName,
                              "S_date": _Startdate.text,
                              "E_date": _Enddate.text,
                              "Lan": LanguageProvider.getLanguage()=="AR"?"Ar":"En",
                            };
                              if(!state){

                               data = {
                                "Emp_no": context.read<AuthViewModel>().UserName,
                                "S_date": _Startdate.text,
                                "E_date": _Enddate.text,
                                "Lan": LanguageProvider.getLanguage()=="AR"?"Ar":"En",
                              };
                              }else{
                                 data = {
                                  "Emp_no": context.read<AuthViewModel>().UserName,
                                  "S_date": _Startdate.text,
                                  "E_date": _Enddate.text,
                                  "Lan": LanguageProvider.getLanguage()=="AR"?"Ar":"En",
                                };
                              }

                    
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                final viewModel = context.read<ProfileViewModel>();


    if(!state){
      viewModel.GetAttendancenew(data, context);
    }
    else{
      viewModel.GetAttendancenewMap(data, context);
    }
                              });
                            },
                          ),
                        ),



                        //---Attence Map

                      state?  Container(
                          margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                          height: MediaQuery.sizeOf(context).height / 2+50,
                          // ,
                          child: Consumer<ProfileViewModel>(builder: (context, value, _) {
                            switch (value.AttendanceMap.status) {
                              case Status.LOADING:
                                return const Center(child: CircularProgressIndicator());
                              case Status.ERROR:
                                return Center(child: Text(value.AttendanceMap.message.toString()));
                              case Status.COMPLETED:
                                return value.AttendanceMap.data!.list != null
                                    ? ListView.builder(
                                    itemCount: value.AttendanceMap.data!.list!.length,
                                    //   physics: const AlwaysScrollableScrollPhysics(), // new
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var startDate = DateFormat('yyyy-MM-dd').parse(value.AttendanceMap.data!.list![index].transDate!);

                                      StartYear = startDate.year.toString();
                                      StartMonth = startDate.month.toString();
                                      StartDay = startDate.day.toString();




                                      return Container(
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
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.27,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          textWidget(StartDay!, 36/sc, FontWeight.w800, ColorTheme(context)),
                                                          const SizedBox(width: 5),
                                                          Column(
                                                            children: [
                                                              textWidget(months[int.parse(StartMonth!)-1], 18/sc, FontWeight.w900, Colors.black),
                                                              textWidget(StartYear!, 18/sc, FontWeight.w500, Colors.black),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    textWidget(value.AttendanceMap.data!.list![index].dayName!, 20/sc, FontWeight.w500, ColorTheme(context)),

                                                    ],
                                                  ),
                                                ),

                                                Container(
                                                    alignment:Alignment.center,
                                                    margin: const EdgeInsets.only(left: 10,right: 10)
                                                    ,child: textWidget(value.AttendanceMap.data!.list![index].decription!, 20/sc, FontWeight.w500, ColorTheme(context))),

                                              ],
                                            ),

                                          ],

                                        ),
                                      );

                                    })
                                    : const Center(
                                  child: Text("no data"),
                                );
                              case null:
                                break;
                            }
                            return Container();
                          }),
                        ): Container(
                        margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                        height: MediaQuery.sizeOf(context).height / 2+50,
                        // ,
                        child: Consumer<ProfileViewModel>(builder: (context, value, _) {
                          switch (value.Attendance.status) {
                            case Status.LOADING:
                              return const Center(child: CircularProgressIndicator());
                            case Status.ERROR:
                              return Center(child: Text(value.Attendance.message.toString()));
                            case Status.COMPLETED:
                              return value.Attendance.data!.list != null
                                  ? ListView.builder(
                                  itemCount: value.Attendance.data!.list!.length,
                                  //   physics: const AlwaysScrollableScrollPhysics(), // new
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var startDate = DateFormat('yyyy-MM-dd').parse(value.Attendance.data!.list![index].attDate!);

                                    StartYear = startDate.year.toString();
                                    StartMonth = startDate.month.toString();
                                    StartDay = startDate.day.toString();

                                    var str = value.Attendance.data!.list![index].sTime!;
                                    var stre = value.Attendance.data!.list![index].eTime!;
                                    var starttime;
                                    var endtime;
                                    if(str.isNotEmpty)
                                    {
                                      starttime = str.split(' ');
                                    }
                                    if(stre.isNotEmpty)
                                    {
                                      endtime = stre.split(' ');
                                    }



                                    return Container(
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
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: width * 0.27,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        textWidget(StartDay!, 36/sc, FontWeight.w800, ColorTheme(context)),
                                                        const SizedBox(width: 5),
                                                        Column(
                                                          children: [
                                                            textWidget(months[int.parse(StartMonth!)-1], 18/sc, FontWeight.w900, Colors.black),
                                                            textWidget(StartYear!, 18/sc, FontWeight.w500, Colors.black),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    textWidget(value.Attendance.data!.list![index].dayofweek1!, 20/sc, FontWeight.w500, ColorTheme(context)),
                                                    const SizedBox(height: 5,),
                                                    SizedBox(
                                                        width:width * 0.25,
                                                        child: textWidgetAligned(value.Attendance.data!.list![index].realDiffInMinDesc!, 15/sc, FontWeight.w500, ColorTheme(context),TextAlign.end)),
                                                    /*
                                                    SizedBox(height: 5,),
                                                    SizedBox(
                                                        width:width * 0.25,
                                                        child: textWidgetAligned(value.Attendance.data!.list![index].decription!, 11, FontWeight.w500, ColorTheme(context),TextAlign.end)),
                    */

                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.25,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    textWidget(LanguageProvider.Llanguage('IN'), 20/sc, FontWeight.w500,
                                                        ColorTheme(context)),
                                                    textWidget(str.isNotEmpty?starttime[0].trim():"", 20/sc, FontWeight.w800,
                                                        greenColor),
                                                    textWidget(str.isNotEmpty?starttime[1].trim():"", 34/sc, FontWeight.w800,
                                                        greenColor),
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
                                                width: width * 0.25,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    textWidget( LanguageProvider.Llanguage('OUT'), 20/sc, FontWeight.w500,
                                                        ColorTheme(context)),
                                                    textWidget(stre.isNotEmpty?endtime[0].trim():"", 20/sc, FontWeight.w800,
                                                        greenColor),
                                                    textWidget(stre.isNotEmpty?endtime[1].trim():"", 34/sc, FontWeight.w800,
                                                        greenColor),
                                                    /*Row(
                                                      children: [
                                                        textWidget("00:00 ", 10,
                                                            FontWeight.w500, Colors.black),
                                                        textWidget("Early Exit", 10, FontWeight.w500,
                                                            appColor),
                                                      ],
                                                    )*/
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5,),
                                          Container(alignment:Alignment.topLeft,
                                              margin: const EdgeInsets.only(left: 10,right: 10)
                                              ,child: textWidget(value.Attendance.data!.list![index].decription!, 20/sc, FontWeight.w500, ColorTheme(context))),

                                        ],

                                      ),
                                    );
                                  })
                                  : const Center(
                                child: Text("no data"),
                              );
                            case null:
                              break;
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
    context.read<Vacationsviewmodel>().setEmpalternative(0,"");
    context.read<Vacationsviewmodel>().setVacationsShowType(0);
  }
}