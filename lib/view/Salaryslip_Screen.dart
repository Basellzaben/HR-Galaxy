import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm/Dialogs/DitalsRequest_Dialog.dart';
import 'package:mvvm/Dialogs/RequestType_Dialog.dart';
import 'package:mvvm/Dialogs/Request_Dialog.dart';

import 'package:mvvm/Dialogs/VacationsDialog.dart';
import 'package:mvvm/data/response/status.dart';

import 'package:mvvm/res/components/round_button.dart';

import 'package:mvvm/view_model/MyRequest_View_Model/My_Request_ViewModel.dart';
import 'package:mvvm/view_model/Profile/Profile_View_Model.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Dialogs/VacationsStatusDialog.dart';
import '../res/components/constants.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/services/LanguagePrvider.dart';

class Salaryslip_Screen extends StatefulWidget {
  const Salaryslip_Screen({Key? key}) : super(key: key);

  @override
  _Salaryslip_ScreenState createState() => _Salaryslip_ScreenState();
}

class _Salaryslip_ScreenState extends State<Salaryslip_Screen> {
  My_Request_ViewModel my_Request_ViewModel = My_Request_ViewModel();
  TextEditingController _Startdate = TextEditingController();
  TextEditingController _Enddate = TextEditingController();

  TextEditingController _EmpName = TextEditingController();

  String selectedMonth = '0';

  String selectedYear = '0';
  late DateTime startDateTime;
  late DateTime endDateTime;
  NumberFormat formatter = new NumberFormat("00");
  DateTime? _selectedDate;
  @override
  void initState() {
    // TODO: implement initState
    //homeViewViewModel.fetchMoviesListApi();
    /*   _EmpName.text=  context.read<AuthViewModel>().Name;
    print('AlertDialog dismissed ' +
        context.read<Vacationsviewmodel>().VacationsTypeName);
    _VacationsType.text = context.read<Vacationsviewmodel>().VacationsTypeName;
    CalDayNumber(1);*/
    String M = DateFormat('MM').format(DateTime.now());
    String y = DateFormat('yyyy').format(DateTime.now());
     selectedMonth = M;

     selectedYear = y;
    _EmpName.text = context.read<AuthViewModel>().Name;
    Map data = {
      "Emp_no": context.read<AuthViewModel>().UserName,
      "year": int.parse(y),
      "Month": int.parse(M),
      "Operation": "all",
    };
    Map data1 = {
      "Emp_no": context.read<AuthViewModel>().UserName,
      "year": int.parse(y),
      "Month": int.parse(M),
      "Operation": "RetWebAdditional",
    };
    Map data2 = {
      "Emp_no": context.read<AuthViewModel>().UserName,
      "year": int.parse(y),
      "Month": int.parse(M),
      "Operation": "RetWebAllwance",
    };
    Map data3 = {
      "Emp_no": context.read<AuthViewModel>().UserName,
      "year": int.parse(y),
      "Month": int.parse(M),
      "Operation": "RetWebDeductPermenent",
    };
    Map data4 = {
      "Emp_no": context.read<AuthViewModel>().UserName,
      "year": int.parse(y),
      "Month": int.parse(M),
      "Operation": "RetWebDiscount",
    };



    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<ProfileViewModel>();
      viewModel.fetchSalaryslipHdr(data, context);

      viewModel.fetchSalaryslip_setSalaryslip_Plugins(data1, context);

      viewModel.fetchSalaryslip_setSalaryslip_bonuses(data2, context);

      viewModel.fetchSalaryslip_setSalaryslip_deductions(data3, context);
      viewModel.fetchSalaryslip_setSalaryslip_Discount(data4, context);

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final fontSize = 20 / textScaleFactor;
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    String M = DateFormat('MM').format(DateTime.now());
    String y = DateFormat('yyyy').format(DateTime.now());


    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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


                    child: Container(

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
                                        "assest/salary_icon.png",
                                        width: 45,
                                        height: 45,
                                        color: ColorTheme(context),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.sizeOf(context).width * 0.025,
                                      ),
                                      textWidget(
                                          LanguageProvider.Llanguage('Salaryslip'), 25/textScaleFactor, FontWeight.w500, Colors.black)
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
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          LanguageProvider.Llanguage('emp'),
                          style: TextFormFieldColor(context),
                        ),
                      ),
                      Container(

                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        child: TextFormField(
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          controller: _EmpName,
                          style: ColorBlack3(context),
                          readOnly: true,
                          decoration: InputDecoration(
                            /*   prefixIcon: Icon(Icons.person),*/

                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5.0),
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
                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        child: SizedBox(

                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: width * 0.05),
                                      child: textWidget(LanguageProvider.Llanguage('month'), 20/textScaleFactor,
                                          FontWeight.w600, ColorTheme(context)),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(12)),
                                        border: Border.all(
                                          color: ColorTheme(context), // Border color
                                          width: 1.2, // Border width
                                        ),
                                      ),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: selectedMonth,
                                        items: monthItems.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item.padLeft(2, '0'), // Ensure two-digit values with leading zeros
                                            child: textWidget(item, 16, FontWeight.w500, Colors.black),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedMonth = newValue!;
                                          });
                                        },
                                        underline: Container(),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: ColorTheme(context),
                                          size: 40,
                                        ),
                                      ),

                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width * 0.4,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: width * 0.05),
                                      child: textWidget(LanguageProvider.Llanguage('year'), 20/textScaleFactor,
                                          FontWeight.w600, ColorTheme(context)),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(12)),
                                        border: Border.all(
                                          color: ColorTheme(context), // Border color
                                          width: 1.2, // Border width
                                        ),
                                      ),
                                      child:DropdownButton<String>(
                                        isExpanded: true,
                                        value: selectedYear, // Set the initially selected item
                                        items: yearItems.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: textWidget(item, 16, FontWeight.w500, Colors.black),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedYear = newValue!; // Update the selected item when the user makes a selection
                                          });
                                        },
                                        underline: Container(),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: ColorTheme(context),
                                          size: 40,
                                        ),

                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: RoundButton(
                          title: LanguageProvider.Llanguage('sendrequest'),
                          loading: false,
                          fontSize: fontSize,
                          onPress: () {
                      //      String M1 = DateFormat('MM').format(_selectedDate!);
                       //     String y1 = DateFormat('yyyy').format(_selectedDate!);
                            Map data = {
                              "Emp_no": context.read<AuthViewModel>().UserName,
                              "year": int.parse(selectedYear),
                              "Month": int.parse(selectedMonth),
                              "Operation": "all",
                            };
                            Map data1 = {
                              "Emp_no": context.read<AuthViewModel>().UserName,
                              "year": int.parse(selectedYear),
                              "Month": int.parse(selectedMonth),
                              "Operation": "RetWebAdditional",
                            };
                            Map data2 = {
                              "Emp_no": context.read<AuthViewModel>().UserName,
                              "year": int.parse(selectedYear),
                              "Month": int.parse(selectedMonth),
                              "Operation": "RetWebAllwance",
                            };
                            Map data3 = {
                              "Emp_no": context.read<AuthViewModel>().UserName,
                              "year": int.parse(selectedYear),
                              "Month": int.parse(selectedMonth),
                              "Operation": "RetWebDeductPermenent",
                            };
                            Map data4 = {
                              "Emp_no": context.read<AuthViewModel>().UserName,
                              "year": int.parse(selectedYear),
                              "Month": int.parse(selectedMonth),
                              "Operation": "RetWebDiscount",
                            };


                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              final viewModel = context.read<ProfileViewModel>();
                              viewModel.fetchSalaryslipHdr(data, context);
                              viewModel.fetchSalaryslip_setSalaryslip_Plugins(data1, context);
                              viewModel.fetchSalaryslip_setSalaryslip_bonuses(data2, context);
                              viewModel.fetchSalaryslip_setSalaryslip_deductions(data3, context);
                              viewModel.fetchSalaryslip_setSalaryslip_Discount(data4, context);
                            });
                          },
                        ),
                      ),
        /*      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: DatePickerWidget(
                              looping: false, // default is not looping
                              firstDate: DateTime(2000, 01, 01),
                              lastDate: DateTime(2050, 1, 1),
                              initialDate: DateTime(int.parse(y), int.parse(M), 1),
                              dateFormat: "MM-yyyy",
                              locale: DatePicker.localeFromString('en'),
                              onChange: (DateTime newDate, _) => _selectedDate = newDate,
                              pickerTheme: DateTimePickerTheme(
                                itemTextStyle: ColorMonthTask(context),
                                dividerColor: ColorTheme(context),
                              ),
                            ),
                          ),

                        ],
                      ),*/
                      Container(
                        child: Consumer<ProfileViewModel>(builder: (context, value, _) {
                          switch (value.SalaryslipHdr.status) {
                            case Status.LOADING:
                              return Center(child: CircularProgressIndicator());
                            case Status.ERROR:
                              return Center(
                                  child: Text(value.SalaryslipHdr.message.toString()));
                            case Status.COMPLETED:
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                                        child: Column(
                                          children: [
                                            salarySlipItems(width,LanguageProvider.Llanguage('basicsalary'),"JD",value.SalaryslipHdr.data!.list![0].basic!.toString(),false,context),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            salarySlipItems(width,LanguageProvider.Llanguage(
                                                'Totalentitlements'),"JD",value.SalaryslipHdr.data!.list![0].add!.toString(),false,context),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            salarySlipItems(width, LanguageProvider.Llanguage('Totaldiscounts'),"JD",value.SalaryslipHdr.data!.list![0].sup!.toString(),false,context),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            salarySlipItems(width,LanguageProvider.Llanguage(
                                                'netsalary'),"JD",value.SalaryslipHdr.data!.list![0].tot!.toString(),true,context),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                          ],
                                        ),
                                      )

,


                                    ],
                                  ),


                                ],
                              );
                          }
                          return Container();
                        }),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).width / 7,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text(
                              LanguageProvider.Llanguage('bonuses'),
                              style: TextStyle(
                                  color: ColorTheme(context),
                                  fontSize: 20/textScaleFactor,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 15, right: 15),
                        height: 200,
                        decoration: BoxDecoration(
                          /*   prefixIcon: Icon(Icons.person),*/
                          color: Colors.white, // لون الخلفية
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: ColorTheme(context),
                              width: 1.0), // هنا يتم استخدام Border
                        ),
                        // ,
                        child:
                            Consumer<ProfileViewModel>(builder: (context, value, _) {
                          switch (value.Salaryslip_bonuses.status) {
                            case Status.LOADING:
                              return Center(child: CircularProgressIndicator());
                            case Status.ERROR:
                              return Center(
                                  child: Text(value.Salaryslip_bonuses.message.toString()));
                            case Status.COMPLETED:
                              return value.Salaryslip_bonuses.data!.list != null
                                  ? ListView.builder(
                                      itemCount: value.Salaryslip_bonuses.data!.list!.length,

                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(left: 10,right: 10),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,

                                            children: [
                                              Container(
                                                width: MediaQuery.sizeOf(context).width/2,
                                                child: Text(value.Salaryslip_bonuses.data!.list![index].eDescription!.toString(),),

                                              )
                                              ,
                                              Container(
                                                child: Text(value.Salaryslip_bonuses.data!.list![index].amt!.toString()),

                                              )
                                            ],
                                          ),
                                        );


                                      })
                                  : Container(
                                alignment:Alignment.topCenter ,
                                      child: Text("no data"),
                                    );
                          }
                          return Container();
                        }),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).width / 7,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text(
                              LanguageProvider.Llanguage('Additional'),
                              style: TextStyle(
                                  color: ColorTheme(context),
                                  fontSize: 20/textScaleFactor,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 15, right: 15),
                        height: 200,
                        decoration: BoxDecoration(
                          /*   prefixIcon: Icon(Icons.person),*/
                          color: Colors.white, // لون الخلفية
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: ColorTheme(context),
                              width: 1.0), // هنا يتم استخدام Border
                        ),
                        // ,
                        child:
                        Consumer<ProfileViewModel>(builder: (context, value, _) {
                          switch (value.Salaryslip_Plugins.status) {
                            case Status.LOADING:
                              return Center(child: CircularProgressIndicator());
                            case Status.ERROR:
                              return Center(
                                  child: Text(value.Salaryslip_Plugins.message.toString()));
                            case Status.COMPLETED:
                              return value.Salaryslip_Plugins.data!.list != null
                                  ? ListView.builder(
                                  itemCount: value.Salaryslip_Plugins.data!.list!.length,

                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 10,right: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,

                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context).width/1.8,
                                            child: Text(value.Salaryslip_Plugins.data!.list![index].eDescription!.toString(),),

                                          )
                                          ,
                                          Container(
                                            child: Text(value.Salaryslip_Plugins.data!.list![index].amt!.toString()),

                                          )
                                        ],
                                      ),
                                    );


                                  })
                                  : Container(
                                alignment:Alignment.topCenter ,
                                child: Text("no data"),
                              );
                          }
                          return Container();
                        }),
                      ),

                      SizedBox(
                        height: MediaQuery.sizeOf(context).width / 7,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text(
                              LanguageProvider.Llanguage('DeductPermenent'),
                              style: TextStyle(
                                  color: ColorTheme(context),
                                  fontSize: 20/textScaleFactor,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 15, right: 15),
                        height: 200,
                        decoration: BoxDecoration(
                          /*   prefixIcon: Icon(Icons.person),*/
                          color: Colors.white, // لون الخلفية
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: ColorTheme(context),
                              width: 1.0), // هنا يتم استخدام Border
                        ),
                        // ,
                        child:
                        Consumer<ProfileViewModel>(builder: (context, value, _) {
                          switch (value.Salaryslip_deductions.status) {
                            case Status.LOADING:
                              return Center(child: CircularProgressIndicator());
                            case Status.ERROR:
                              return Center(
                                  child: Text(value.Salaryslip_deductions.message.toString()));
                            case Status.COMPLETED:
                              return value.Salaryslip_deductions.data!.list != null
                                  ? ListView.builder(
                                  itemCount: value.Salaryslip_deductions.data!.list!.length,

                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 10,right: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,

                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context).width/1.8,
                                            child: Text(value.Salaryslip_deductions.data!.list![index].eDescription!.toString(),),

                                          )
                                          ,
                                          Container(
                                            child: Text(value.Salaryslip_deductions.data!.list![index].amt!.toString()),

                                          )
                                        ],
                                      ),
                                    );


                                  })
                                  : Container(
                                alignment:Alignment.topCenter ,
                                child: Text("no data"),
                              );
                          }
                          return Container();
                        }),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).width / 7,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text(
                              LanguageProvider.Llanguage('Discount'),
                              style: TextStyle(
                                  color: ColorTheme(context),
                                  fontSize: 20/textScaleFactor,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 15, right: 15),
                        height: 200,
                        decoration: BoxDecoration(
                          /*   prefixIcon: Icon(Icons.person),*/
                          color: Colors.white, // لون الخلفية
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: ColorTheme(context),
                              width: 1.0), // هنا يتم استخدام Border
                        ),
                        // ,
                        child:
                        Consumer<ProfileViewModel>(builder: (context, value, _) {
                          switch (value.Salaryslip_Discount.status) {
                            case Status.LOADING:
                              return Center(child: CircularProgressIndicator());
                            case Status.ERROR:
                              return Center(
                                  child: Text(value.Salaryslip_Discount.message.toString()));
                            case Status.COMPLETED:
                              return value.Salaryslip_Discount.data!.list != null
                                  ? ListView.builder(
                                  itemCount: value.Salaryslip_Discount.data!.list!.length,

                                  itemBuilder: (context, index) {
                                    return SizedBox(

                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10,right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,

                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context).width/1.8,
                                              child: Text(value.Salaryslip_Discount.data!.list![index].eDescription!.toString(),),

                                            )
                                            ,
                                            Container(
                                              child: Text(value.Salaryslip_Discount.data!.list![index].amt!.toString()),

                                            )
                                          ],
                                        ),
                                      ),
                                    );


                                  })
                                  : Container(
                                alignment:Alignment.topCenter ,
                                child: Text("no data"),
                              );
                          }
                          return Container();
                        }),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).width /7,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Center(

                          ),
                        ),
                      ),

                    ],
                  ),
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
