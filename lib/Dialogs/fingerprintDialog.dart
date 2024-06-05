
import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/Home/HomeNew_View_Model.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';
import '../view_model/user_view_model.dart';


class fingerprintDialog extends StatefulWidget {
  const fingerprintDialog({Key? key}) : super(key: key);

  @override
  _fingerprintDialogState createState() => _fingerprintDialogState();
}

class _fingerprintDialogState extends State<fingerprintDialog> {

  Vacationsviewmodel  vacationsviewmodel = Vacationsviewmodel();

  @override
  void initState() {
    // TODO: implement initState


    Map data = {
      'empNo': context.read<AuthViewModel>().UserName,
      'actionNo': context.read<HomeNewViewModel>().ActionNo,
      'coor_X': context.read<HomeNewViewModel>().lat,
      'coor_Y': context.read<HomeNewViewModel>().long,
      'tabletName': context.read<HomeNewViewModel>().ID,
    };

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final viewModel = context.read<HomeNewViewModel>();
      viewModel.GetCheckInOut(data, context);
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        height: 250,
        child: AlertDialog(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          contentPadding: EdgeInsets.only(
            top: 10.0,
          ),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          content:  Container(

            child: Scaffold(

              body:  Consumer<HomeNewViewModel>(
                builder: (context, value, _) {
                  switch (value.CheckINO.status) {
                    case Status.LOADING:
                      return Center(
                        child: Dialog(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 16.0),
                                Text("Loading..."),
                              ],
                            ),
                          ),
                        ),
                      );
                    case Status.ERROR:
                      return Center(
                        child: Text(value.HomeData.message.toString()),
                      );
                    case Status.COMPLETED:
                      return Center(
                        child: Text("OK"),
                      );


                    case null:
                      // TODO: Handle this case.
                  }
                  return Container();
                },


            ),
          ),)

    ));
  }
}