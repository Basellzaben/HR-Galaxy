
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/Home/HomeNew_View_Model.dart';
import 'package:mvvm/view_model/MyRequest_View_Model/My_Request_ViewModel.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../res/components/constants.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/services/LanguagePrvider.dart';
import '../view_model/user_view_model.dart';


class ShowImageDialog extends StatefulWidget {
  const ShowImageDialog({Key? key}) : super(key: key);

  @override
  _ShowImageDialogState createState() => _ShowImageDialogState();
}

class _ShowImageDialogState extends State<ShowImageDialog> {

  My_Request_ViewModel  vacationsviewmodel = My_Request_ViewModel();
  String langg="";

  @override
  void initState() {
    // TODO: implement initState
    langg =  context.read<Language>().langg;

    Map data = {
      'emp_no': context.read<AuthViewModel>().UserName,
      'vac_type': context.read<My_Request_ViewModel>().TypeRequset,
      'iD': context.read<My_Request_ViewModel>().RequestWorkFlow,

    };
    WidgetsBinding
        .instance
        .addPostFrameCallback((_){
      final viewModel = context.read<HomeNewViewModel>();
      viewModel.GetImageVM(data,context);}
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
                  'Image'),textAlign:TextAlign.center ,
              style: TextStyle(  fontSize: 25 / MediaQuery.of(context).textScaleFactor),
            ),
            content:  Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: Scaffold(

                body:
              //  context
                 /*   .read<My_Request_ViewModel>()
                    .RequestNo!=0?*/
                Consumer<HomeNewViewModel>(
                    builder: (context, value, _){

                      switch(value.getimage.status){
                        case Status.LOADING:
                          return Center(child: CircularProgressIndicator());
                        case Status.ERROR:
                          return Center(child: Text(value.getimage.message.toString()));
                        case Status.COMPLETED:
                          return
                            PhotoView(
                              imageProvider: CachedNetworkImageProvider(
                                value.getimage.data!.list![0].imagePath!,
                              ),
                              loadingBuilder: (context, event) {
                                if (event == null) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
                                    ),
                                  );
                                }
                              },
                            );


                      }
                      return Container();
                    })
                 /* :
                Center(child: Text("No Data", style: ColorBlack(context)),),*/

              ),
            ),)

      ),
    );
  }
}