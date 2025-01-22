// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvvm/Dialogs/AllEmployeeDialog.dart';
import 'package:mvvm/Dialogs/VacationsDialog.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/res/components/Pop.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/HomeHR_Screen.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../res/components/constants.dart';
import '../utils/utils.dart';
import '../view_model/services/LanguagePrvider.dart';

class VacatlonScreen extends StatefulWidget {
  const VacatlonScreen({Key? key}) : super(key: key);

  @override
  _VacatlonScreenState createState() => _VacatlonScreenState();
}

class _VacatlonScreenState extends State<VacatlonScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  TextEditingController _Startdate = TextEditingController();
  TextEditingController _Enddate = TextEditingController();
  TextEditingController _Daynumber = TextEditingController();
  TextEditingController _VacationsType = TextEditingController();
  TextEditingController _Balance = TextEditingController();
  TextEditingController _NOte = TextEditingController();
  TextEditingController _EmpName = TextEditingController();
  TextEditingController _AlternateEmployee = TextEditingController();
  TextEditingController _Add = TextEditingController();
  String Upload = "Upload Documents";
  String  base64Image = "";

  @override
  void initState() {
    // TODO: implement initState
    //homeViewViewModel.fetchMoviesListApi();

    _EmpName.text=  context.read<AuthViewModel>().Name;
   

    Map data = {
      "EmployeeNo": context.read<AuthViewModel>().UserName,
      "VacatiosType": 1,
      "StartDate": _Startdate.text.toString(),
      "EndDate": _Enddate.text.toString(),
    };

    WidgetsBinding
        .instance
        .addPostFrameCallback((_){
           Clear();
    CalDayNumber(1);
      final viewModel = context.read<Vacationsviewmodel>();
      viewModel.fetchVacationsData(data,context);}
    );


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
            body:  Consumer<Vacationsviewmodel>(
                builder: (context, Vacation, _) {
                  switch (Vacation.VacatiosData.status) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(child: Text(Vacation.VacatiosData.message.toString()));
                    case Status.COMPLETED:
                      _Balance.text = Vacation.VacatiosData.data?.list?[0].balance?.toString() ?? "0";
                      _Daynumber.text = Vacation.VacatiosData.data?.list?[0].dayDiff?.toString() ?? "0";
                     
                      return  SingleChildScrollView(
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                            
                            
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 35),
                                    width: MediaQuery.sizeOf(context).width/1.2,
                                    child: AutoSizeText( LanguageProvider.Llanguage('vacationrequest'),
                                        maxLines: 1, style: ColorThemeHdr(context))),
                                Container(
                                  padding: const EdgeInsets.only(left: 5, right: 5, top: 30),
                            
                                  child: InkWell(
                                    onTap: () {
                                      Clear();
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
                            Container(

                              margin: const EdgeInsets.only(left: 30 ,right: 30,top: 10),
                              child: Text(
                                LanguageProvider
                                    .Llanguage(
                                    'emp'),
                                style: TextFormFieldColor(context),
                              ),
                            ),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width /1.2,
                              margin: const EdgeInsets.only(left: 30, right: 30, top: 5),
                              child: TextFormField(
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                controller: _EmpName,
                                style: ColorBlack3(context) ,
                                readOnly: true,
                                decoration: InputDecoration(
                                  /*   prefixIcon: Icon(Icons.person),*/

                                  contentPadding:
                                  const EdgeInsets.symmetric(
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
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: SBorderside(context),
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ),
                            Container(

                              margin: const EdgeInsets.only(left: 30 ,right: 30,top: 10),
                              child: Text(
                                LanguageProvider
                                    .Llanguage(
                                    'requesttype'),
                                style: TextFormFieldColor(context),
                              ),
                            ),
                            Container(

                              margin: const EdgeInsets.only(left: 30, right: 30, top: 5),
                              child: TextFormField(
                                readOnly: true,
                                controller: _VacationsType,
                                style: ColorBlack3(context) ,
                                decoration: InputDecoration(
                                  /*   prefixIcon: Icon(Icons.person),*/
                                  contentPadding:
                                  const EdgeInsets.symmetric(
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
                                                       Vacation.VacationsTypeName);
                                                    _VacationsType.text = Vacation.VacationsTypeName;
                                                    return true;
                                                  },
                                                  child: const VacationsDialog());
                                            }).then((value) {
                                          print(context.read<Vacationsviewmodel>().VacationsShowType);
                                          if(Vacation.VacationsShowType !=0)
                                          {
                                            _VacationsType.text =Vacation.VacationsTypeName;


                                            Map data = {
                                              "EmployeeNo": context.read<AuthViewModel>().UserName,
                                              "VacatiosType": Vacation.VacationsShowType,
                                              "StartDate": _Startdate.text.toString(),
                                              "EndDate": _Enddate.text.toString(),
                                            };

                                            WidgetsBinding
                                                .instance
                                                .addPostFrameCallback((_){
                                              // final viewModel = context.read<Vacationsviewmodel>();
                                              Vacation.fetchVacationsData(data,context);}
                                            );
                                          }});

                                      },
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
                            Row(children: [
                              Container(
                                width: MediaQuery.of(context).size.width /4,
                                margin: const EdgeInsets.only(left: 30 ,right: 30,top: 10),
                                child: Text(
                                  LanguageProvider
                                      .Llanguage(
                                      'datestartvaction'),
                                  style: TextFormFieldColor(context),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width /4,
                                margin: const EdgeInsets.only(left: 30 ,right: 30,top: 10),
                                child: Text(
                                  LanguageProvider
                                      .Llanguage(
                                      'dateendvaction'),
                                  style: TextFormFieldColor(context),
                                ),
                              ),
                            ],),
                            Row(children: [
                              Container(

                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2.5,
                                margin: context.read<Language>().langg=="EN"?const EdgeInsets.only(left: 30 ,right: 10,top: 5)
                                    :const EdgeInsets.only(left: 10 ,right: 30,top: 5),
                                child: TextFormField(
                                 maxLines: 1,
                                  style: TextFormFieldColor3(context) ,
                                  onChanged: (text) {
                                    CalDayNumber(2);
                                  },
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: _Startdate,
                                  readOnly: true,
                                  decoration: InputDecoration(


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
                                              _Enddate.text =formattedDate;
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
                              Container(

                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2.5,
                                margin: context.read<Language>().langg=="EN"?const EdgeInsets.only(left: 0 ,right: 30,top: 5)
                                    :const EdgeInsets.only(left: 30 ,right: 0,top: 5),
                                child: TextFormField(
                                  maxLines: 1,
                                  style: TextFormFieldColor3(context) ,
                                  onChanged: (text) {
                                    CalDayNumber(2);
                                  },
                                  textAlignVertical: TextAlignVertical.center,
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
                            ],),

                            Container(

                              margin: const EdgeInsets.only(left: 30 ,right: 30,top: 10),
                              child: Text(
                                LanguageProvider
                                    .Llanguage(
                                    'emmployees'),
                                style: TextFormFieldColor(context),
                              ),
                            ),
                            Container(

                              margin: const EdgeInsets.only(left: 30, right: 30, top: 5),
                              child: TextFormField(
                                style: ColorBlack3(context) ,
                                controller: _AlternateEmployee,
                                readOnly: true,
                                decoration: InputDecoration(
                                  /*   prefixIcon: Icon(Icons.person),*/

                                  contentPadding:
                                  const EdgeInsets.symmetric(
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
                                                    _VacationsType.text = Vacation.VacationsTypeName;
                                                    return true;
                                                  },
                                                  child: const AllEmployeeDialog());
                                            }).then((value) {
                                          _AlternateEmployee.text = Vacation.EmpNamealternative;
                                        });
                                      },
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
                            Row(children: [
                              Container(
                                width: MediaQuery.of(context).size.width /4,
                                margin: const EdgeInsets.only(left: 30 ,right: 30,top: 10),
                                child: Text(
                                  LanguageProvider
                                      .Llanguage(
                                      'Departuretime'),
                                  style: TextFormFieldColor(context),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width /2.5,
                                margin: const EdgeInsets.only(left: 30 ,right: 30,top: 10),
                                child: Text(
                                  LanguageProvider
                                      .Llanguage(
                                      'vacations'),
                                  style: TextFormFieldColor2(context),
                                ),
                              ),
                            ],),
                            Row(children: [
                              Container(

                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2.5,
                                margin: context.read<Language>().langg=="EN"?const EdgeInsets.only(left: 30 ,right: 10,top: 5)
                                    :const EdgeInsets.only(left: 10 ,right: 30,top: 5),
                                child: TextFormField(
                                  style: ColorBlack(context) ,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  controller: _Daynumber,
                                  // controller: TextEditingController(text: value.VacatiosData.data!.list![0].dayDiff!.toString()),
                                  decoration: InputDecoration(
                                    /*   prefixIcon: Icon(Icons.person),*/
                                    labelStyle: ColorBlack(context),
                                    hintStyle: ColorBlack(context),
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
                              Container(

                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2.5,
                                margin: context.read<Language>().langg=="EN"?const EdgeInsets.only(left: 0 ,right: 30,top: 5)
                                    :const EdgeInsets.only(left: 30 ,right: 0,top: 5),
                                child: TextFormField(
                                  style: ColorBlack(context) ,
                                  textAlign: TextAlign.center,
                                  controller: _Balance,
                                  // controller: TextEditingController(text: value.VacatiosData.data!.list![0].balance!.toString()),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    /*   prefixIcon: Icon(Icons.person),*/

                                    labelStyle: ColorBlack(context),
                                    hintStyle: ColorBlack(context),
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
                            ],),

                            Container(

                              margin: const EdgeInsets.only(left: 30 ,right: 30,top: 10),
                              child: Text(
                                LanguageProvider
                                    .Llanguage(
                                    'phoneanddetails'),
                                style: TextFormFieldColor(context),
                              ),
                            ),
                            Container(

                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              margin: const EdgeInsets.only(left: 30, right: 30, top: 5),
                              child: TextFormField(
                                controller: _Add,
                                style: ColorBlack(context) ,
                                decoration: InputDecoration(
                                  /*   prefixIcon: Icon(Icons.person),*/

                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 1.0),
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
                              children: [
                                    Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width/4,
                                        margin: const EdgeInsets.only(left: 30 ,right: 30,top: 10),
                                       
                                      
                                  child: InkWell(
                                    onTap: () async {
                                      final ImagePicker picker = ImagePicker();
                                  // Pick an image.
                                      final XFile? image =
                                      await picker.pickImage(source: ImageSource.gallery);
                                      Vacation.setImag_Name(image!.name.toString());
                                  
                                       final imageBytes = await image!.readAsBytes();
                                  
                                        base64Image = base64Encode(imageBytes);
                                  
                                    //    print(imageBytes);
                                        print(image!.name.toString());
                                                                    
                                  
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 30 ,right: 30,top: 10),
                                      child: Icon(
                                        size: 30,
                                        Icons.add_circle_outline_outlined,
                                        color: ColorBlue(),
                                      ),
                                    ),
                                  ),
                                ),
                                 Text(
                                          Vacation.Imag_Name== ""?LanguageProvider.Llanguage(
                                            'uploadimage'):Vacation.Imag_Name,
                                          style: TextFormFieldColor(context),
                                        ),
                              ],
                          
                            ),
                            
                            Container(
                              margin: const EdgeInsets.only(left: 30 ,right: 30,top: 10),
                              child: Text(
                                LanguageProvider
                                    .Llanguage(
                                    'notes'),
                                style: TextFormFieldColor(context),
                              ),
                            ),
                            Container(

                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              margin: const EdgeInsets.only(left: 30, right: 30, top: 5),
                              child: TextFormField(
                                controller: _NOte,
                                style: ColorBlack(context) ,
                                decoration: InputDecoration(
                                  /*   prefixIcon: Icon(Icons.person),*/

                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 1.0),
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
                            Container(
                              margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
                              child: RoundButton(
                                title:  LanguageProvider.Llanguage(
                                    'sendrequest'),
                                loading: Vacation.loading,
                                fontSize: 20/MediaQuery.of(context).textScaleFactor, 
                                onPress: () async{
                                   int check = Vacation.VacationsShowType;
                                if( check ==0)
                                {
                                  if(LanguageProvider.getLanguage()=="AR")
                                  {
                                    Utils.flushBarErrorMessage("يجب ادخال نوع الطلب",context);

                                  }
                                  else
                                  {
                                    Utils.flushBarErrorMessage("You must enter the Request Type ",context);

                                  }
                                  return;
                                }
                                  if(Vacation.VacatiosData.data!.list![0].isBackUpEmp ==1)
                                {
                                  if(Vacation.EmpShowNoalternative==0 ||Vacation.EmpShowNoalternative==null)
                                  {
                                    if(LanguageProvider.getLanguage()=="AR")
                                    {
                                      Utils.flushBarErrorMessage("يجب أدخال الموظف البديل",context);

                                    }
                                    else
                                    {
                                      Utils.flushBarErrorMessage("The replacement employee must be entered",context);

                                    }
                                    return;
                                  }

                                }

                                if(Vacation.VacatiosData.data!.list![0].isAddress ==1)
                                {
                                  if(_Add.text.toString()=="" || _Add.text.toString()==null)
                                  {
                                    if(LanguageProvider.getLanguage()=="AR")
                                    {
                                      Utils.flushBarErrorMessage("يجب أدخال العنوان ورقم الهاتف",context);

                                    }
                                    else
                                    {
                                      Utils.flushBarErrorMessage("You must enter the address and phone number",context);

                                    }
                                    return;
                                  }

                                }
                              
                                  if(Vacation.VacatiosData.data!.list![0].isDocmetion ==1)
                                  {
                                    if(Vacation.Imag_Name=="" || Vacation.Imag_Name==null)
                                    {
                                      if(LanguageProvider.getLanguage()=="AR")
                                      {
                                        Utils.flushBarErrorMessage(" يجب أدخال الوثيقة ",context);

                                      }
                                      else
                                      {
                                        Utils.flushBarErrorMessage("You must enter the document   ",context);

                                      }
                                      return;
                                    }

                                  }


                                if(_NOte.text.toString()=="" || _NOte.text.toString()==null)
                                {
                                  if(LanguageProvider.getLanguage()=="AR")
                                  {
                                    Utils.flushBarErrorMessage("يجب أدخال الملاحظات",context);

                                  }
                                  else
                                  {
                                    Utils.flushBarErrorMessage("You must enter the Notes",context);

                                  }
                                  return;
                                }
                               


                                var prefix ="";
                                if( base64Image.toString()!="") {
                                var parts = Vacation.Imag_Name.toString().split('.');
                                prefix = parts[1].trim() !=null ?parts[1].trim():"";
                               }

                                Map data = {
                                  "Emp_no": context.read<AuthViewModel>().UserName.toString(),
                                  "vac_type":Vacation.
                                      VacationsShowType==0?1:Vacation
                                      .VacationsShowType.toString(),
                                  "starting_date": _Startdate.text.toString(),
                                  "ending_date": _Enddate.text.toString(),
                                  "status":"0",
                                  "request_date": "1999-01-01",
                                  "Number": _Daynumber.text.toString(),
                                  "WFRequestID": "1",
                                  "reason":_NOte.text.toString(),
                                  "address": _Add.text.toString(),
                                  "remarks": _NOte.text.toString(),
                                  "Ramt": _Balance.text.toString(),
                                  "WFReqType": Vacation.VacationsShowType.toString(),
                                  "ActionNo": "5",
                                  "Image": base64Image,
                                  "Type": prefix
                                };

                             WidgetsBinding
                                      .instance
                                      .addPostFrameCallback((_)async{
                                  //final   viewModel1 = context.read<Vacationsviewmodel>();
                                await  Vacation.SaveVactEmp(data,LanguageProvider.getLanguage(),context);
 if(Vacation.chex==1)
                                {
                                 Vacation.setVacations(0,"");
                                 Vacation.setImag_Name("");
    Vacation.setEmpalternative(0, "");
    _AlternateEmployee.text=Vacation.EmpNamealternative;
                                  // Clear();
                                  _NOte.text="";
                                  _Add.text="";

                                  _VacationsType.text = Vacation.VacationsTypeName;
                                  CalDayNumber(1);

                                  Map data = {
                                    "EmployeeNo": context.read<AuthViewModel>().UserName,
                                    "VacatiosType": 1,
                                    "StartDate": _Startdate.text.toString(),
                                    "EndDate": _Enddate.text.toString(),
                                  };

                                    // final viewModel = context.read<Vacationsviewmodel>();
                                   Vacation.fetchVacationsData(data,context);
                                 Vacation.setchex(0);

                                }
                                      });
                                
                               
                              },

                              ),
                            ),

                  const SizedBox(height: 20,)
                          ],
                        ),
                      );

                    case null:
                      // TODO: Handle this case.
                      break;
                  }
                  return
                    Container
                      (
                    );
                }
            )
        ),
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
        "VacatiosType": context.read<Vacationsviewmodel>()
            .VacationsShowType==0?1:context.read<Vacationsviewmodel>()
            .VacationsShowType,
        "StartDate": _Startdate.text.toString(),
        "EndDate": _Enddate.text.toString(),
      };

      WidgetsBinding
          .instance
          .addPostFrameCallback((_){
        final viewModel = context.read<Vacationsviewmodel>();
        viewModel.fetchVacationsData(data,context);}
      );



    }
  }

 void Clear() {
    context.read<Vacationsviewmodel>().setVacationsTypeName("");
    context.read<Vacationsviewmodel>().setEmpalternative(0, "");
    context.read<Vacationsviewmodel>().setVacationsShowType(0);
  }
}
