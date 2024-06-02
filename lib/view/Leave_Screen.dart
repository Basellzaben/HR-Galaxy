
import 'dart:convert';
import 'dart:typed_data';

import 'package:hex/hex.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mvvm/Dialogs/LeaveDialog.dart';

import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../res/components/constants.dart';
import '../view_model/services/LanguagePrvider.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({Key? key}) : super(key: key);

  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  late var startTime = DateTime.now();
  late var EndTime = DateTime.now();

  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  TextEditingController _Startdate = TextEditingController();
  TextEditingController _Enddate = TextEditingController();
  TextEditingController _Daynumber = TextEditingController();
  TextEditingController _VacationsType = TextEditingController();
  TextEditingController _EmpName = TextEditingController();
  TextEditingController _NOte = TextEditingController();
  TextEditingController _Endstart = TextEditingController();
  TextEditingController _StartTime = TextEditingController();
  String Upload = "Upload Documents";

  String  base64Image = "";
  @override
  void initState() {
    // TODO: implement initState
    //homeViewViewModel.fetchMoviesListApi();
    _EmpName.text = context.read<AuthViewModel>().Name;

    CalDayNumber(1);

    Map data = {
      "EmployeeNo": context.read<AuthViewModel>().UserName,
      "VacatiosType": 1,
      "StartDate": _Startdate.text.toString(),
      "EndDate": _Enddate.text.toString(),
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<Vacationsviewmodel>();
      viewModel.fetchVacationsData(data, context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    final ViewMode = Provider.of<Vacationsviewmodel>(context);
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
            body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                child: Row(


                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 35),
                        width: MediaQuery.sizeOf(context).width/1.2,
                        child: AutoSizeText( LanguageProvider.Llanguage('leaverequest'),
                            maxLines: 1, style: ColorThemeHdr(context))),
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5, top: 30),

                      child: InkWell(
                        onTap: () {

                          //   Navigator.pushNamed(context, RoutesName.homeHR);
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
                margin: EdgeInsets.only(left: 30, right: 30, top: 35),
                child: Text(
                  LanguageProvider.Llanguage('emp'),
                  style: TextFormFieldColor(context),
                ),
              ),
              Container(

                margin: EdgeInsets.only(left: 30, right: 20, top: 5),
                child: TextFormField(
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  controller: _EmpName,
                  readOnly: true,
                  style: ColorBlack3(context),
                  decoration: InputDecoration(
                    /*   prefixIcon: Icon(Icons.person),*/

                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 5.0),
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
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Text(
                  LanguageProvider.Llanguage('Departuretype'),
                  style: TextFormFieldColor(context),
                ),
              ),
              Container(

                margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                child: TextFormField(
                  readOnly: true,
                  style: ColorBlack3(context),
                  controller: _VacationsType,
                  decoration: InputDecoration(
                    /*   prefixIcon: Icon(Icons.person),*/
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 5.0),
                    labelStyle: ColorBlack3(context),
                    hintStyle: ColorBlack3(context),
                    suffixIcon: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return WillPopScope(
                                    onWillPop: () async {
                                      // Perform custom action when AlertDialog is closed
                                      print('AlertDialog dismissed1');
                                      print('AlertDialog dismissed ' +
                                          context
                                              .read<Vacationsviewmodel>()
                                              .VacationsTypeName);
                                      _VacationsType.text = context
                                          .read<Vacationsviewmodel>()
                                          .VacationsTypeName;
                                      return true;
                                    },
                                    child: LeaveDialog());
                              }).then((value) {
                            _VacationsType.text = context
                                .read<Vacationsviewmodel>()
                                .VacationsTypeName;

                            Map data = {
                              "EmployeeNo":
                                  context.read<AuthViewModel>().UserName,
                              "VacatiosType": context
                                  .read<Vacationsviewmodel>()
                                  .VacationsShowType,
                              "StartDate": _Startdate.text.toString(),
                              "EndDate": _Enddate.text.toString(),
                            };

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              final viewModel =
                                  context.read<Vacationsviewmodel>();
                              viewModel.fetchVacationsData(data, context);
                            });
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
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Text(
                  LanguageProvider.Llanguage('Departuredate'),
                  style: TextFormFieldColor(context),
                ),
              ),
              Container(


                margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                child: TextFormField(
                  style: TextFormFieldColor(context),
                  onChanged: (text) {
                    CalDayNumber(2);
                  },
                  textAlignVertical: TextAlignVertical.center,
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
                            DateFormat('yyyy-MM-dd')
                                .format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              _Startdate.text = formattedDate;
                              print(_Startdate.text);
                              //set output date to TextField value.
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: SBorderside(context),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        margin: LanguageProvider.getLanguage()=="EN"?EdgeInsets.only(left: 30, right: 1, top: 20):EdgeInsets.only(left: 1, right: 30, top: 20),
                        child: Text(
                          LanguageProvider.Llanguage('Departurestarttime'),
                          style: TextFormFieldColor(context),
                        ),
                      ),
                      Container(

                        width: MediaQuery.of(context).size.width / 3 + 20,
                        margin: LanguageProvider.getLanguage()=="EN"?EdgeInsets.only(left: 30, right: 1, top: 5):EdgeInsets.only(left: 1, right: 30, top: 5),

                        child: TextFormField(

                          style: TextFormFieldColor2(context),
                          onChanged: (text) {
                            CalDayNumber(2);
                          },
                          textAlignVertical: TextAlignVertical.center,
                          controller: _StartTime,
                          readOnly: true,
                          decoration: InputDecoration(
                            /*   prefixIcon: Icon(Icons.person),*/
                            labelStyle: ColorBlack(context),
                            hintStyle: ColorBlack(context),
                            suffixIcon: InkWell(
                                onTap: () async {
                                  final TimeOfDay? result = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      builder: (context, childWidget) {
                                        return MediaQuery(
                                            data: MediaQuery.of(context).copyWith(
                                                // Using 24-Hour format
                                                alwaysUse24HourFormat: true),
                                            // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                                            child: childWidget!);
                                      });
                                  if (result != null) {
                                    setState(() {
                                      DateTime dt =
                                          DateTime.parse(_Startdate.text);
                                      startTime = DateTime(dt.year, dt.month,
                                          dt.day, result.hour, result.minute);
                                      print(startTime.toString());
                                      _StartTime.text = result.format(context);
                                      CalDayNumber(2);
                                    });
                                  }
                                },
                                child: Icon(
                                  size: 30,
                                  Icons.timer_outlined,
                                  color: ColorBlue(),
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
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: LanguageProvider.getLanguage()=="EN"?EdgeInsets.only(left: 1, right: 30, top: 20):EdgeInsets.only(left: 30, right: 1, top: 20),
                        child: Text(
                          LanguageProvider.Llanguage('Departureendtime'),
                          style: TextFormFieldColor(context),
                        ),
                      ),
                      Container(

                        width: MediaQuery.of(context).size.width / 3 +20,
                        margin: LanguageProvider.getLanguage()=="EN"?EdgeInsets.only(left: 1, right: 30, top: 5):EdgeInsets.only(left: 30, right: 1, top: 5),
                        child: TextFormField(
                          style: TextFormFieldColor2(context),
                          onChanged: (text) {
                            CalDayNumber(2);
                          },
                          textAlignVertical: TextAlignVertical.center,
                          controller: _Endstart,
                          readOnly: true,
                          decoration: InputDecoration(
                            /*   prefixIcon: Icon(Icons.person),*/
                            labelStyle: ColorBlack(context),
                            hintStyle: ColorBlack(context),
                            suffixIcon: InkWell(
                                onTap: () async {
                                  final TimeOfDay? result = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      builder: (context, childWidget) {
                                        return MediaQuery(
                                            data: MediaQuery.of(context).copyWith(
                                                // Using 24-Hour format
                                                alwaysUse24HourFormat: true),
                                            // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                                            child: childWidget!);
                                      });
                                  if (result != null) {
                                    setState(() {
                                      DateTime dt =
                                          DateTime.parse(_Startdate.text);
                                      EndTime = DateTime(dt.year, dt.month,
                                          dt.day, result.hour, result.minute);
                                      print(startTime.toString());
                                      //  _StartTime.text = result.format(context) ;
                                      _Endstart.text = result.format(context);
                                      CalDayNumber(2);
                                    });
                                  }
                                },
                                child: Icon(
                                  size: 30,
                                  Icons.timer_outlined,
                                  color: ColorBlue(),
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
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: Text(
                          LanguageProvider.Llanguage('Departuretime'),
                          style: TextFormFieldColor(context),
                        ),
                      ),
                      Container(

                        width: MediaQuery.of(context).size.width / 3 + 20,
                        margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                        child: TextFormField(
                          style: ColorBlack(context),
                          textAlign: TextAlign.center,
                          readOnly: true,
                          controller: _Daynumber,
                          //     controller: TextEditingController(text: value.VacatiosData.data!.list![0].dayDiff!.toString()),
                          decoration: InputDecoration(
                            /*   prefixIcon: Icon(Icons.person),*/
                            labelStyle: ColorBlack(context),
                            hintStyle: ColorBlack(context),
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
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
// Pick an image.
                      final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                      setState(() async {

                        final imageBytes = await image!.readAsBytes();

                        base64Image = base64Encode(imageBytes);

                        //    print(imageBytes);
                        print(image!.name.toString());

                        Upload = image!.name.toString();


                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 30 ,right: 30,top: 10),
                      child: Icon(
                        size: 30,
                        Icons.add_circle_outline_outlined,
                        color: ColorBlue(),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width/2,
                    margin: EdgeInsets.only(top: 10, left: 30),
                    child: Text(
                      Upload,
                      style: TextFormFieldColor(context),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Text(
                  LanguageProvider.Llanguage('notes'),
                  style: TextFormFieldColor(context),
                ),
              ),
              Container(

                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: _NOte,
                  style: ColorBlack(context),
                  decoration: InputDecoration(
                    /*   prefixIcon: Icon(Icons.person),*/

                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 1.0),
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
                margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                child: RoundButton(
                  title: LanguageProvider.Llanguage('sendrequest'),
                  loading: ViewMode.loading,
                  fontSize: 20 / MediaQuery.of(context).textScaleFactor,
                  onPress: () {
                    var prefix ="";
                    if( base64Image.toString()!="") {
                      var parts = Upload.toString().split('.');
                      prefix = parts[1].trim() !=null ?parts[1].trim():"";
                    }

                    Map data = {
                      "Emp_no": context.read<AuthViewModel>().UserName.toString(),
                      "vac_type":
                          context.read<Vacationsviewmodel>().VacationsShowType ==
                                  0
                              ? 1
                              : context
                                  .read<Vacationsviewmodel>()
                                  .VacationsShowType
                                  .toString(),
                      "starting_date": _StartTime.text.toString(),
                      "ending_date": _Endstart.text.toString(),
                      "status": "0",
                      "request_date": _Startdate.text.toString(),
                      "Number": _Daynumber.text.toString(),
                      "WFRequestID": "2",
                      "reason": _NOte.text.toString(),
                      "address": '',
                      "remarks": _NOte.text.toString(),
                      "Ramt": '0',
                      "WFReqType": context
                          .read<Vacationsviewmodel>()
                          .VacationsShowType
                          .toString(),
                      "ActionNo": "5",
                      "Image": base64Image,
                      "Type": prefix
                    };

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      //final   viewModel1 = context.read<Vacationsviewmodel>();
                      ViewMode.SaveVactEmp(
                          data, LanguageProvider.getLanguage(), context);
                    });
                    if (context.read<Vacationsviewmodel>().chex == 1) {
                      context.read<Vacationsviewmodel>().setVacations(0, "");
                      _NOte.text = "";
                      CalDayNumber(1);

                      Map data = {
                        "EmployeeNo": context.read<AuthViewModel>().UserName,
                        "VacatiosType": 1,
                        "StartDate": _Startdate.text.toString(),
                        "EndDate": _Enddate.text.toString(),
                      };

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        final viewModel = context.read<Vacationsviewmodel>();
                        viewModel.fetchVacationsData(data, context);
                      });
                    }
                  },
                ),
              ),
             SizedBox(height: 20,)
            ],
          ),
        )),
      ),
    );
  }

  void CalDayNumber(int flag) {
    if (flag == 1) {
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      _Startdate.text = currentDate;
    } else {
      if (_StartTime != "" && _Endstart != "") {
        Duration diff = EndTime.difference(startTime);
        int hours = diff.inMinutes ~/ 60;
        int remainingMinutes = diff.inMinutes % 60;
        print(hours.toString());
        print(remainingMinutes.toString());
        _Daynumber.text =
            (hours.toString() + ":" + remainingMinutes.toString()).toString();
      }
    }
  }
}
