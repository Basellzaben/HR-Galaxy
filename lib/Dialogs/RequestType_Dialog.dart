
import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/MyRequest_View_Model/My_Request_ViewModel.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../res/components/constants.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/services/LanguagePrvider.dart';
import '../view_model/user_view_model.dart';


class RequestType_Dialog extends StatefulWidget {
  const RequestType_Dialog({Key? key}) : super(key: key);

  @override
  _RequestType_DialogState createState() => _RequestType_DialogState();
}

class _RequestType_DialogState extends State<RequestType_Dialog> {

  My_Request_ViewModel  vacationsviewmodel = My_Request_ViewModel();
  String langg="";

  @override
  void initState() {
    // TODO: implement initState
    langg =  context.read<Language>().langg;
print(context
    .read<My_Request_ViewModel>()
    .RequestNo.toString()+"sadasd");
    Map data = {
      'Type': context
        .read<My_Request_ViewModel>()
        .RequestNo.toString(),

    };
    WidgetsBinding
        .instance
        .addPostFrameCallback((_){
      final viewModel = context.read<My_Request_ViewModel>();
      viewModel.fetchAllRequst(data,context);}
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    var LanguageProvider = Provider.of<Language>(context, listen: false);
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
                color: ColorTheme(context),  // Set the border color
                width: 5.0,         // Set the border width
                style: BorderStyle.solid,  // Set the border style
              ),

            ),
            contentPadding: EdgeInsets.only(
                top: 20.0,
                bottom: 20
            ),
            title: Text(
              LanguageProvider.Llanguage(
                  'requesttype'),textAlign:TextAlign.center ,
              style: TextStyle(  fontSize: 25 / MediaQuery.of(context).textScaleFactor),
            ),
            content:  Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: Scaffold(

                body: context
                    .read<My_Request_ViewModel>()
                    .RequestNo!=0?
                Consumer<My_Request_ViewModel>(
                    builder: (context, value, _){

                      switch(value.AllRequst.status){
                        case Status.LOADING:
                          return Center(child: CircularProgressIndicator());
                        case Status.ERROR:
                          return Center(child: Text(value.AllRequst.message.toString()));
                        case Status.COMPLETED:
                          return ListView.builder(
                              itemCount: value.AllRequst.data!.list!.length,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: (){
                                    // print('AlertDialog dismissed '+(value.VacationsType.data!.list![index].englishDescription!));
                                    if(langg == 'AR') {
                                      context.read<My_Request_ViewModel>()
                                          .setRequestType(
                                          (value.AllRequst.data!.list![index]
                                              .type!),
                                          value.AllRequst.data!.list![index]
                                              .arabicDescription!);
                                    }
                                    else
                                      {

                                        context.read<My_Request_ViewModel>()
                                            .setRequestType(
                                            (value.AllRequst.data!.list![index]
                                                .type!),
                                            value.AllRequst.data!.list![index]
                                                .englishDescription!);
                                      }
                                    Navigator.of(context).pop();
                                  },
                                  child: Card(

                                      child: Container(
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: Text(langg=="EN"?value.AllRequst.data!.list![index].englishDescription!:value.AllRequst.data!.list![index].arabicDescription!,style: ColorBlack(context),
                                          ))
                                  ),
                                );
                              });

                        case null:
                          // TODO: Handle this case.
                      }
                      return Container();
                    }):
                Center(child: Text("No Data", style: ColorBlack(context)),),

              ),
            ),)

      ),
    );
  }
}