import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/res/components/MenuItem.dart';
import 'package:mvvm/utils/routes/routes_name.dart';

import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Dialogs/fingerprintDialog.dart';
import '../res/components/constants.dart';
import '../view_model/MyRequest_View_Model/My_Request_ViewModel.dart';
import '../view_model/Profile/Profile_View_Model.dart';

class notifications_screen extends StatefulWidget {
  const notifications_screen({Key? key}) : super(key: key);

  @override
  _notifications_screenState createState() => _notifications_screenState();
}

class _notifications_screenState extends State<notifications_screen> {
  ProfileViewModel my_Request_ViewModel = ProfileViewModel();
  @override
  void initState() {
    // TODO: implement initState

    //x = MediaQuery.sizeOf(context).height * 0.1;

    Map data = {
      'emp_No': context.read<AuthViewModel>().UserName,
      'id':  1,
      'date':"formattedDate",
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {

      final viewModel = context.read<ProfileViewModel>();
      viewModel.GetNotifidata(data, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    var LanguageProvider = Provider.of<Language>(context, listen: false);
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
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Container(

                  width: MediaQuery.sizeOf(context).width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(

                        child: Row(


                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 10, right: 10, top: 35),
                                width: MediaQuery.sizeOf(context).width/1.2,
                                child: AutoSizeText( LanguageProvider.Llanguage('notifications'),
                                    maxLines: 2, style: ColorThemeHdr(context))),
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 5, top: 30),

                              child: InkWell(
                                onTap: () {

                                  //   Navigator.pushNamed(context, RoutesName.homeHR);
                                  Navigator.pop(context);
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
                        margin: EdgeInsets.only(top: 0, left: 15, right: 15),
                        height: MediaQuery.sizeOf(context).height ,
                        // ,
                        child: Consumer<ProfileViewModel>(builder: (context, value, _) {
                          switch (value.Noto.status) {
                            case Status.LOADING:
                              return Center(child: CircularProgressIndicator());
                            case Status.ERROR:
                              return Center(child: Text(value.Noto.message.toString()));
                            case Status.COMPLETED:

                              return value.Noto.data!.list != null
                                  ? ListView.builder(
                                  itemCount: value.Noto.data!.list!.length,
                                  //   physics: const AlwaysScrollableScrollPhysics(), // new
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var startDate = DateFormat('yyyy-MM-dd').parse(value.Noto.data!.list![index].dayDate!);

                                    return
                                         GestureDetector(
                                      onTap: () {

                                      },
                                      child: Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20)),
                                          child: Container(
                                            width:
                                            MediaQuery.sizeOf(context).width,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,

                                              children: [
                                                Container(
                                                  width: MediaQuery.sizeOf(context).width/5,

                                                  child:
                                                Icon(
                                                  Icons.notifications_none,
                                                  color: ColorTheme(context)
                                                  ,size: 30,

                                                )
                                                ),
                                                Container(
                                                  width: 3,
                                                  height: MediaQuery.sizeOf(context).height/10,
                                                  color: ColorTheme(context),
                                                ),
                                                Expanded(
                                                  child: Container(

                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            margin: EdgeInsets.only(top: 0,right: 10,left: 10),
                                                            child: Text(LanguageProvider.getLanguage()=="AR"?value
                                                                .Noto
                                                                .data!
                                                                .list![index]
                                                                .fieldVal!:value
                                                                .Noto
                                                                .data!
                                                                .list![index]
                                                                .fieldValEn!,style: TextStyle(fontSize: 15),)),
                                                        Container(
                                                          margin: EdgeInsets.only(right: 10,left: 10),

                                                          child: Text(
                                                              startDate.year.toString()+"/"+startDate.month.toString()+"/"+startDate.day.toString(),
                                                              style:
                                                              ColorDayTask(context)),
                                                        )

                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    );

                                  })
                                  : Center(
                                child: Text("no data"),
                              );
                            case null:
                              // TODO: Handle this case.
                          }
                          return Container();
                        }),
                      ),


                    ],
                  ),
                ))),
      ),
    );
  }


}
