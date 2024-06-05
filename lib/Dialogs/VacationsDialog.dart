
import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../res/components/constants.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/services/LanguagePrvider.dart';
import '../view_model/user_view_model.dart';


class VacationsDialog extends StatefulWidget {
  const VacationsDialog({Key? key}) : super(key: key);

  @override
  _VacationsDialogState createState() => _VacationsDialogState();
}

class _VacationsDialogState extends State<VacationsDialog> {

  Vacationsviewmodel  vacationsviewmodel = Vacationsviewmodel();
  String langg="";
  @override
  void initState() {
    // TODO: implement initState
    langg =  context.read<Language>().langg;
    Map data = {
      'EmployeeNo': context.read<AuthViewModel>().UserName.toString(),

    };
    final viewModel = context.read<Vacationsviewmodel>();
     WidgetsBinding
        .instance
        .addPostFrameCallback((_){
    viewModel.fetchVacationsTypeList(data,context);
    });
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
            LanguageProvider
                .Llanguage(
                'requesttype'),textAlign:TextAlign.center ,
        style: TextStyle(fontSize: 20.0/ MediaQuery.of(context).textScaleFactor),
        ),
            content:  Container(
          height: 350,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(

            body:  Consumer<Vacationsviewmodel>(
                  builder: (context, value, _){

                    switch(value.VacationsType.status){
                      case Status.LOADING:
                        return Center(child: CircularProgressIndicator());
                      case Status.ERROR:
                        return Center(child: Text(value.VacationsType.message.toString()));
                      case Status.COMPLETED:
                        return ListView.builder(
                            itemCount: value.VacationsType.data!.list!.length,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                  if(langg == 'AR')
                                    {
                                      context.read<Vacationsviewmodel>().setVacations(value.VacationsType.data!.list![index].type!,value.VacationsType.data!.list![index].arabicDescription!);

                                    }
                                  else
                                    {
                                      context.read<Vacationsviewmodel>().setVacations(value.VacationsType.data!.list![index].type!,value.VacationsType.data!.list![index].englishDescription!);

                                    }
                                 // print('AlertDialog dismissed '+(value.VacationsType.data!.list![index].englishDescription!));
                                  Navigator.of(context).pop();
                                },
                                child: Card(

                                  child: Container(
                                    height: 50,
                                      alignment: Alignment.center,
                                      child: Text(langg=='EN'?value.VacationsType.data!.list![index].englishDescription!:value.VacationsType.data!.list![index].arabicDescription!,style: ColorBlack(context) ))
                                ),
                              );
                            });

                      case null:
                        // TODO: Handle this case.
                    }
                    return Container();
                  }),

          ),
        ),)

      ),
    );
  }
}