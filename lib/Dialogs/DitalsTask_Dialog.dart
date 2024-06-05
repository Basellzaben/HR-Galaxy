import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/res/components/constants.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/MyRequest_View_Model/My_Request_ViewModel.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';
import '../view_model/services/LanguagePrvider.dart';
import '../view_model/user_view_model.dart';

class DitalsTask_Dialog extends StatefulWidget {
  const DitalsTask_Dialog({Key? key}) : super(key: key);

  @override
  _DitalsTask_DialogState createState() => _DitalsTask_DialogState();
}

class _DitalsTask_DialogState extends State<DitalsTask_Dialog> {
  My_Request_ViewModel vacationsviewmodel = My_Request_ViewModel();

  @override
  void initState() {
    // TODO: implement initState

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
      "WFRequestID": context.read<My_Request_ViewModel>().Requesteww,
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<My_Request_ViewModel>();
      viewModel.fetchTaskDatadetails(data, context);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel2 = context.read<Vacationsviewmodel>();
      viewModel2.fetchGetApprovalHiostry(data2, context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    final ViewMode = Provider.of<Vacationsviewmodel>(context);

    return Directionality(
      textDirection: LanguageProvider.getDirection(),
      child: Container(
          child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.0,
            ),
          ),
          side: BorderSide(
            color: ColorTheme(context), // Set the border color
            width: 5.0, // Set the border width
            style: BorderStyle.solid, // Set the border style
          ),
        ),
        contentPadding: EdgeInsets.only(top: 20.0, bottom: 20),
        title: Text(
          LanguageProvider.Llanguage('task'),
          textAlign: TextAlign.center,
          style: ColorThemeHdr(context),
        ),
        content: Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(body:
              Consumer<My_Request_ViewModel>(builder: (context, value, _) {
            switch (value.TaskDatadetails.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(
                    child: Text(value.TaskDatadetails.message.toString()));
              case Status.COMPLETED:
                var date = DateFormat('yyyy/MM/dd')
                    .parse(value.TaskDatadetails.data!.list![0].wdate!);
                /*   return ListView.builder(
                              itemCount: value.AllRequst.data!.list!.length,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: (){
                                    // print('AlertDialog dismissed '+(value.VacationsType.data!.list![index].englishDescription!));
                                    context.read<My_Request_ViewModel>().setRequestType((value.AllRequst.data!.list![index].type!),value.AllRequst.data!.list![index].englishDescription!);

                                    Navigator.of(context).pop();
                                  },
                                  child: Card(

                                      child: Container(
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: Text(value.AllRequst.data!.list![index].englishDescription!,))
                                  ),
                                );
                              });*/
                return SafeArea(
                  child: Column(children: [
                    Card(
                      margin: EdgeInsets.all(10),
                      elevation: 10,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width ,
                            margin:
                                EdgeInsets.only(right: 15, left: 15, top: 5),
                            child: Text(
                              LanguageProvider.Llanguage('sender'),
                              style: TextFormFieldColor(context),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(right: 15, left: 15, top: 5),
                            child: Text(
                              LanguageProvider.getLanguage() == 'AR'
                                  ? value.TaskDatadetails.data!.list![0].reqEmp!
                                  : value
                                      .TaskDatadetails.data!.list![0].reqEmpEN!,
                              style: TextStyle(
                                  fontSize: 18 /
                                      MediaQuery.of(context).textScaleFactor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 15, left: 15, top: 10),
                                  child: Text(
                                    LanguageProvider.Llanguage('requesttype2'),
                                    style: TextFormFieldColor3(context),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 15, left: 15, top: 5),
                                  child: Text(
                                    LanguageProvider.Llanguage('reqstatus2'),
                                    style: TextFormFieldColor3(context),
                                  ),
                                ),
                                /*    Container(
                                  margin:
                                      EdgeInsets.only(right: 15, left: 15, top: 5),
                                  child: Text(
                                    LanguageProvider.Llanguage('sender'),
                                    style: TextFormFieldColor(context),
                                  ),
                                ),*/
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 15, left: 15, top: 5),
                                  child: Text(
                                    LanguageProvider.Llanguage('reqDate'),
                                    style: TextFormFieldColor3(context),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 15, left: 15, top: 5),
                                  child: Text(
                                    LanguageProvider.Llanguage('notes'),
                                    style: TextFormFieldColor3(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(right: 3, left: 3, top: 10),
                                child: Text(
                                  ":",
                                  style: TextFormFieldColor3(context),
                                ),
                              ),
                              /*      Container(
                                margin: EdgeInsets.only(right: 3, left: 3, top: 5),
                                child: Text(
                                  ":",
                                  style: TextFormFieldColor(context),
                                ),
                              ),*/
                              Container(
                                margin:
                                    EdgeInsets.only(right: 3, left: 3, top: 5),
                                child: Text(
                                  ":",
                                  style: TextFormFieldColor3(context),
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(right: 3, left: 3, top: 5),
                                child: Text(
                                  ":",
                                  style: TextFormFieldColor3(context),
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(right: 3, left: 3, top: 5),
                                child: Text(
                                  ":",
                                  style: TextFormFieldColor3(context),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 15, left: 15, top: 5),
                                  child: Text(
                                    LanguageProvider.getLanguage() == 'AR'
                                        ? value.TaskDatadetails.data!.list![0]
                                            .requestDescNew!
                                        : value.TaskDatadetails.data!.list![0]
                                            .requestDescEnNew!,
                                    style: ColorBlack1(context),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 15, left: 15, top: 5),
                                  child: Text(
                                      int.parse(value.TaskDatadetails.data!
                                                  .list![0].wfAction!) ==
                                              5
                                          ? LanguageProvider.Llanguage('new')
                                          : int.parse(value
                                                      .TaskDatadetails
                                                      .data!
                                                      .list![0]
                                                      .wfAction!) ==
                                                  1
                                              ? LanguageProvider.Llanguage(
                                                  'acceptable')
                                              : LanguageProvider.Llanguage(
                                                  'rejected'),
                                      style: ColorBlack1(context)),
                                ),
                                /*
                                Container(
                                  margin:
                                  EdgeInsets.only(right: 15, left: 15, top: 5),
                                  child: Text(
                                    LanguageProvider.getLanguage() == 'AR'
                                        ? value.TaskDatadetails.data!.list![0].reqEmp!
                                        : value.TaskDatadetails.data!.list![0].reqEmpEN!,
                                    style: TextStyle(
                                        fontSize:
                                        18 / MediaQuery.of(context).textScaleFactor),
                                  ),
                                ),*/

                                Container(
                                  margin: EdgeInsets.only(
                                      right: 15, left: 15, top: 5),
                                  child: Text(
                                    date.year.toString() +
                                        "/" +
                                        date.month.toString() +
                                        "/" +
                                        date.day.toString(),
                                    style: ColorBlack1(context),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 15, left: 15, top: 5),
                                  child: Text(
                                    int.parse(value.TaskDatadetails.data!
                                                .list![0].wfRequestID!) ==
                                            1
                                        ? value.TaskDatadetails.data!.list![0]
                                            .vNotes!
                                        : value.TaskDatadetails.data!.list![0]
                                            .lNotes!,
                                    style: ColorBlack1(context),
                                  ),
                                ),
                              ],
                            ),
                          ),

/*
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              LanguageProvider.Llanguage('history'),
                              style: TextFormFieldColor(context),
                            ),
                          ),
                          Container(
                              height: 100,
                              child: Consumer<Vacationsviewmodel>(
                                builder: (context, value, _) {
                                  switch (value.GetApprovalH.status) {
                                    case Status.LOADING:
                                      return Center(
                                          child: CircularProgressIndicator());
                                    case Status.ERROR:
                                      return Center(
                                          child: Text(value.GetApprovalH.message
                                              .toString()));
                                    case Status.COMPLETED:
                                      return ListView.builder(
                                          itemCount:
                                              value.GetApprovalH.data!.list == null
                                                  ? 0
                                                  : value.GetApprovalH.data!.list!
                                                      .length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                // print('AlertDialog dismissed '+(value.VacationsType.data!.list![index].englishDescription!));
                                                */ /*  context.read<My_Request_ViewModel>().setRequestType((value.AllRequst.data!.list![index].type!),value.AllRequst.data!.list![index].englishDescription!);

                                        Navigator.of(context).pop();*/ /*
                                              },
                                              child: Card(
                                                  child: Column(
                                                children: [
                                                  Container(
                                                      height: 20,
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                          value
                                                              .GetApprovalH
                                                              .data!
                                                              .list![index]
                                                              .userFName!,
                                                          style: TextStyle(
                                                            color: value
                                                                        .GetApprovalH
                                                                        .data!
                                                                        .list![
                                                                            index]
                                                                        .actionNo ==
                                                                    1
                                                                ? Colors.green
                                                                : value
                                                                            .GetApprovalH
                                                                            .data!
                                                                            .list![
                                                                                index]
                                                                            .actionNo ==
                                                                        2
                                                                    ? Colors.red
                                                                    : Colors.grey,
                                                          ))),
                                                  Container(
                                                      height: 20,
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        value.GetApprovalH.data!
                                                            .list![index].note!,
                                                      )),
                                                ],
                                              )),
                                            );
                                          });
                                  }
                                  return Container();
                                },
                              )),


                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.document_scanner,
                                      color: HexColor('#0E7289'),
                                      size: 50,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Map data = {
                                        "ID": context
                                            .read<My_Request_ViewModel>()
                                            .RequestWorkFlow,
                                        "WFRequestID": context
                                            .read<My_Request_ViewModel>()
                                            .Requesteww,
                                        "ActionNo": 2,
                                      };

                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        //final   viewModel1 = context.read<Vacationsviewmodel>();
                                        ViewMode.SaveApproval(
                                            data,
                                            LanguageProvider.getLanguage(),
                                            context);
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      "assest/cancel.svg",
                                      semanticsLabel: 'Acme Logo',
                                      color: Colors.red,
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Map data = {
                                        "ID": context
                                            .read<My_Request_ViewModel>()
                                            .RequestWorkFlow,
                                        "WFRequestID": context
                                            .read<My_Request_ViewModel>()
                                            .Requesteww,
                                        "ActionNo": 1,
                                      };

                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        //final   viewModel1 = context.read<Vacationsviewmodel>();
                                        ViewMode.SaveApproval(
                                            data,
                                            LanguageProvider.getLanguage(),
                                            context);
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      "assest/check_circle.svg",
                                      semanticsLabel: 'Acme Logo',
                                      color: Colors.green,
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      elevation: 10,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width ,
                            margin: EdgeInsets.all(10),
                            child: Text(
                              LanguageProvider.Llanguage('history'),
                              style: TextFormFieldColor(context),
                            ),
                          ),
                          Container(
                              height: 150,
                              child: Consumer<Vacationsviewmodel>(
                                builder: (context, value, _) {
                                  switch (value.GetApprovalH.status) {
                                    case Status.LOADING:
                                      return Center(
                                          child: CircularProgressIndicator());
                                    case Status.ERROR:
                                      return Center(
                                          child: Text(value.GetApprovalH.message
                                              .toString()));
                                    case Status.COMPLETED:
                                      return ListView.builder(
                                          itemCount:
                                              value.GetApprovalH.data!.list ==
                                                      null
                                                  ? 0
                                                  : value.GetApprovalH.data!
                                                      .list!.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                // print('AlertDialog dismissed '+(value.VacationsType.data!.list![index].englishDescription!));
                                                //*  context.read<My_Request_ViewModel>().setRequestType((value.AllRequst.data!.list![index].type!),value.AllRequst.data!.list![index].englishDescription!);

                                                Navigator.of(context).pop(); //*
                                              },
                                              child: Card(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      height: 20,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child:
                                                          Text(
                                                              value
                                                                  .GetApprovalH
                                                                  .data!
                                                                  .list![index]
                                                                  .userFName!,
                                                              style: TextStyle(
                                                                color: value
                                                                            .GetApprovalH
                                                                            .data!
                                                                            .list![
                                                                                index]
                                                                            .actionNo ==
                                                                        1
                                                                    ? Colors
                                                                        .green
                                                                    : value.GetApprovalH.data!.list![index].actionNo ==
                                                                            2
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .grey,
                                                              ))),
                                                  Container(
                                                      height: 20,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        value.GetApprovalH.data!
                                                            .list![index].note!,
                                                      )),
                                                ],
                                              )),
                                            );
                                          });
                                    case null:
                                      // TODO: Handle this case.
                                  }
                                  return Container();
                                },
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Icon(
                                Icons.document_scanner,
                                color: HexColor('#0E7289'),
                                size: 50,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Map data = {
                                  "ID": context
                                      .read<My_Request_ViewModel>()
                                      .RequestWorkFlow,
                                  "WFRequestID": context
                                      .read<My_Request_ViewModel>()
                                      .Requesteww,
                                  "ActionNo": 2,
                                };

                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  //final   viewModel1 = context.read<Vacationsviewmodel>();
                                  ViewMode.SaveApproval(data,
                                      LanguageProvider.getLanguage(), context);
                                });
                              },
                              child: SvgPicture.asset(
                                "assest/cancel.svg",
                                semanticsLabel: 'Acme Logo',
                                color: Colors.red,
                                width: 50,
                                height: 50,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Map data = {
                                  "ID": context
                                      .read<My_Request_ViewModel>()
                                      .RequestWorkFlow,
                                  "WFRequestID": context
                                      .read<My_Request_ViewModel>()
                                      .Requesteww,
                                  "ActionNo": 1,
                                };

                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  //final   viewModel1 = context.read<Vacationsviewmodel>();
                                  ViewMode.SaveApproval(data,
                                      LanguageProvider.getLanguage(), context);
                                });
                              },
                              child: SvgPicture.asset(
                                "assest/check_circle.svg",
                                semanticsLabel: 'Acme Logo',
                                color: Colors.green,
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                );
              case null:
                // TODO: Handle this case.
            }
            return Container();
          })),
        ),
      )),
    );
  }
}
