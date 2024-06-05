
import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/res/components/constants.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';
import '../view_model/services/LanguagePrvider.dart';
import '../view_model/user_view_model.dart';


class AllEmployeeDialog extends StatefulWidget {
  const AllEmployeeDialog({Key? key}) : super(key: key);

  @override
  _AllEmployeeDialogState createState() => _AllEmployeeDialogState();
}

class _AllEmployeeDialogState extends State<AllEmployeeDialog> {

  Vacationsviewmodel  vacationsviewmodel = Vacationsviewmodel();
  String langg="";
  @override
  void initState() {
    // TODO: implement initState
     langg =  context.read<Language>().langg;
    // print('AlertDialog dismissed '+(value.VacationsType.data!.list![index].englishDescription!));
    print(langg);
    WidgetsBinding
        .instance
        .addPostFrameCallback((_){
      final viewModel = context.read<Vacationsviewmodel>();
      viewModel.fetchAllEmpList(context);}
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
                LanguageProvider
                    .Llanguage(
                    'emmployees'),textAlign:TextAlign.center ,
              style: TextStyle(fontSize: 20.0/ MediaQuery.of(context).textScaleFactor),
            ),
            content:  Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: Scaffold(

                body:  Consumer<Vacationsviewmodel>(
                    builder: (context, value, _){

                      switch(value.AllEmployee.status){
                        case Status.LOADING:
                          return Center(child: CircularProgressIndicator());
                        case Status.ERROR:
                          return Center(child: Text(value.AllEmployee.message.toString()));
                        case Status.COMPLETED:
                          return ListView.builder(

                              itemCount: value.AllEmployee.data!.list!.length,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: (){
                                    String langg =  context.read<Language>().langg;
                                    // print('AlertDialog dismissed '+(value.VacationsType.data!.list![index].englishDescription!));
                                    print(langg);
                                    if(langg == 'AR')
                                    {
                                      value.setEmpalternative(int.parse(value.AllEmployee.data!.list![index].employeeNo!),value.AllEmployee.data!.list![index].arabicName!);

                                    }
                                    else
                                      {
                                       value.setEmpalternative(int.parse(value.AllEmployee.data!.list![index].employeeNo!),value.AllEmployee.data!.list![index].englishName!);

                                      }

                                    Navigator.of(context).pop();
                                  },
                                  child: Card(
                                      color: Colors.white,
                                      child: Container(
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: Text(langg=='EN'?value.AllEmployee.data!.list![index].englishName!:value.AllEmployee.data!.list![index].arabicName!,style: ColorBlack(context) ))
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