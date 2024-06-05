import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/res/components/constants.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/MyRequest_View_Model/My_Request_ViewModel.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';
import '../view_model/user_view_model.dart';

class DitalsRequest_Dialog extends StatefulWidget {
  const DitalsRequest_Dialog({Key? key}) : super(key: key);

  @override
  _RequestType_DialogState createState() => _RequestType_DialogState();
}

class _RequestType_DialogState extends State<DitalsRequest_Dialog> {
  My_Request_ViewModel vacationsviewmodel = My_Request_ViewModel();
  Vacationsviewmodel Vacationsviewmodel1 = Vacationsviewmodel();

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
    final userPrefernece = Provider.of<UserViewModel>(context);
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    String langg = "";
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
              LanguageProvider.Llanguage('myreqD'),
              textAlign: TextAlign.center,
              style:
              TextStyle(fontSize: 20 / MediaQuery.of(context).textScaleFactor),
            ),
            content: Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: Scaffold(body:
              Consumer<My_Request_ViewModel>(builder: (context, value, _) {
                switch (value.MyRequestDatadetails.status) {
                  case Status.LOADING:
                    return Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(
                        child: Text(value.MyRequestDatadetails.message.toString()));
                  case Status.COMPLETED:
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
                    langg = context.read<Language>().langg;
                    // print('AlertDialog dismissed '+(value.VacationsType.data!.list![index].englishDescription!));
                    print(langg);

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  LanguageProvider.Llanguage('requesttype'),
                                  style: TextFormFieldColor(context),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  langg == 'AR'
                                      ? value.MyRequestDatadetails.data!.list![0]
                                      .requestNameArabic!
                                      : value.MyRequestDatadetails.data!.list![0]
                                      .requestNameEn!,
                                  style: TextStyle(
                                      fontSize: 18 /
                                          MediaQuery.of(context).textScaleFactor),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  LanguageProvider.Llanguage('reqstatus'),
                                  style: TextFormFieldColor(context),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                    value.MyRequestDatadetails.data!.list![0]
                                        .requestAction ==
                                        5
                                        ? LanguageProvider.Llanguage('new')
                                        : value.MyRequestDatadetails.data!.list![0]
                                        .requestAction ==
                                        1
                                        ? LanguageProvider.Llanguage(
                                        'acceptable')
                                        : LanguageProvider.Llanguage(
                                        'rejected'),
                                    style: TextStyle(
                                        fontSize: 18 /
                                            MediaQuery.of(context)
                                                .textScaleFactor)),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              LanguageProvider.Llanguage('Directresponsible'),
                              style: TextFormFieldColor(context),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              langg == 'AR'
                                  ? value.MyRequestDatadetails.data!.list![0]
                                  .empArabic!
                                  : value
                                  .MyRequestDatadetails.data!.list![0].empEn!,
                              style: TextStyle(
                                  fontSize:
                                  18 / MediaQuery.of(context).textScaleFactor),
                            ),
                          ),
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
                                      return Center(child: CircularProgressIndicator());
                                    case Status.ERROR:
                                      return Center(
                                          child: Text(value.GetApprovalH.message
                                              .toString()));
                                    case Status.COMPLETED:
                                      return ListView.builder(
                                          itemCount: value.GetApprovalH.data!.list==null?0:value.GetApprovalH.data!.list!.length,
                                          itemBuilder: (context,index){
                                            return GestureDetector(
                                              onTap: (){
                                                // print('AlertDialog dismissed '+(value.VacationsType.data!.list![index].englishDescription!));
                                                /*  context.read<My_Request_ViewModel>().setRequestType((value.AllRequst.data!.list![index].type!),value.AllRequst.data!.list![index].englishDescription!);

                                    Navigator.of(context).pop();*/
                                              },
                                              child: Card(

                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          height: 20,


                                                          alignment: Alignment.center,
                                                          child: Text(value.GetApprovalH.data!.list![index].userFName!,style: TextStyle( color:value.GetApprovalH.data!.list![index].actionNo==1?Colors.green :value.GetApprovalH.data!.list![index].actionNo==2? Colors.red:Colors.grey,))),
                                                      Container(
                                                          height: 20,
                                                          alignment: Alignment.center,
                                                          child: Text(value.GetApprovalH.data!.list![index].note!,)),
                                                    ],

                                                  )
                                              ),
                                            );
                                          });
                                    case null:
                                      // TODO: Handle this case.
                                  }
                                  return Container();
                                },
                              )),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              LanguageProvider.Llanguage('reqDate'),
                              style: TextFormFieldColor(context),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                                value.MyRequestDatadetails.data!.list![0]
                                    .requestDate!,
                                style: TextStyle(
                                    fontSize: 18 /
                                        MediaQuery.of(context).textScaleFactor)),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              LanguageProvider.Llanguage('notes'),
                              style: TextFormFieldColor(context),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              value.MyRequestDatadetails.data!.list![0].request == 1
                                  ? value
                                  .MyRequestDatadetails.data!.list![0].vNotes!
                                  : value
                                  .MyRequestDatadetails.data!.list![0].lNotes!,
                              style: TextStyle(
                                  fontSize:
                                  13 / MediaQuery.of(context).textScaleFactor),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              LanguageProvider.Llanguage('notesM'),
                              style: TextFormFieldColor(context),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              value
                                  .MyRequestDatadetails.data!.list![0].mangerNotes!,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.document_scanner,
                                  color: HexColor('#0E7289'),
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
