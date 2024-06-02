
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


class VacationsStatusDialog extends StatefulWidget {
  const VacationsStatusDialog({Key? key}) : super(key: key);

  @override
  _VacationsStatusDialogState createState() => _VacationsStatusDialogState();
}

class _VacationsStatusDialogState extends State<VacationsStatusDialog> {

  Vacationsviewmodel  vacationsviewmodel = Vacationsviewmodel();
  String langg="";

  @override
  void initState() {
    // TODO: implement initState
    langg =  context.read<Language>().langg;

    WidgetsBinding
        .instance
        .addPostFrameCallback((_){
      final viewModel = context.read<Vacationsviewmodel>();
      viewModel.fetchStatesV(context);}
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
                    .read<Vacationsviewmodel>()
                    .setRequstStates!=null?
                Consumer<Vacationsviewmodel>(
                    builder: (context, value, _){

                      switch(value.setRequstStates.status){
                        case Status.LOADING:
                          return Center(child: CircularProgressIndicator());
                        case Status.ERROR:
                          return Center(child: Text(value.setRequstStates.message.toString()));
                        case Status.COMPLETED:
                          return ListView.builder(
                              itemCount: value.setRequstStates.data!.list!.length,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: (){
                                    // print('AlertDialog dismissed '+(value.VacationsType.data!.list![index].englishDescription!));
                                    if(langg == 'AR') {
                                      context.read<Vacationsviewmodel>()
                                          .setVacationstates(
                                          (value.setRequstStates.data!.list![index]
                                              .msgID!),
                                          value.setRequstStates.data!.list![index]
                                              .msg!);
                                    }
                                    else
                                    {

                                      context.read<Vacationsviewmodel>()
                                          .setVacationstates(
                                          (value.setRequstStates.data!.list![index]
                                              .msgID!),
                                          value.setRequstStates.data!.list![index]
                                              .msgEN!);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: Card(

                                      child: Container(
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: Text(langg=="EN"?value.setRequstStates.data!.list![index].msgEN!:value.setRequstStates.data!.list![index].msg!,style: ColorBlack(context),
                                          ))
                                  ),
                                );
                              });

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