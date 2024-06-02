
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:mvvm/Dialogs/ChangePassword_Dialog.dart';
import 'package:mvvm/res/components/constants.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/services/GlobalVal.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';

import 'package:provider/provider.dart';
import '../Dialogs/custom_dialog.dart';
import '../view_model/user_view_model.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [0.0, 1.00];
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.homeHR,
                (Route<dynamic> route) => false);

        return false;
      },
      child: Stack(children: <Widget>[

        Scaffold(



            backgroundColor: ColorTheme(context),
            // backgroundColor: Colors.transparent,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height ,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HexColor('#fff'),
                    ColorTheme(context)
                  ],
                  stops: stops,
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                ),
              ),
              child: Directionality(
                textDirection: LanguageProvider.getDirection(),
                child: SafeArea(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                  
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0.0),
                          bottomRight: Radius.circular(40.0),
                          topLeft: Radius.circular(0.0),
                          bottomLeft: Radius.circular(40.0)),
                    ),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      padding: const EdgeInsets.only(left: 11, right: 11),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                    alignment: LanguageProvider.Align(),
                                    child: Text(
                                      LanguageProvider.Llanguage("general"),
                                      style: TextStyle(
                                          fontSize: 18/ MediaQuery.of(context).textScaleFactor,
                                          color: HexColor('#000'),
                                          fontWeight: FontWeight.w500),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                  
                                    setState(() {
                                      if (LanguageProvider.getLanguage() ==
                                          'AR') {
                                        LanguageProvider.setLanguage('EN');
                                      } else {
                                        LanguageProvider.setLanguage('AR');
                                      }
                                    });
                                    await DatabaseHelper.updateLang(
                                        LanguageProvider.langg);
                  
                                    // SharedPreferences pref =
                                    // await SharedPreferences.getInstance();
                                    // pref.setString(
                                    //     'language', LanguageProvider.langg);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.language,
                                        color:
                                        HexColor('#0E7289'),
                                        size: 35 * unitHeightValue,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        LanguageProvider.Llanguage('language'),
                                        style: TextStyle(
                                            fontSize: 18/ MediaQuery.of(context).textScaleFactor,
                                            color:
                                            HexColor('#000'),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const Spacer(),
                                      Text(
                                        LanguageProvider.getLanguage(),
                                        style: TextStyle(
                                          fontSize: 18/ MediaQuery.of(context).textScaleFactor,
                                          color: HexColor('#000'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                const Divider(thickness: 1.0, color: Colors.black),
                                InkWell(
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return WillPopScope(
                                              onWillPop: () async {
                                                return true;
                                              },
                                              child: const ChangePassword_Dialog());
                                        }).then((value) {
                  
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.change_circle_outlined,
                                        color:
                                        HexColor('#0E7289'),
                                        size: 35 * unitHeightValue,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        LanguageProvider.Llanguage('Gangepasswor'),
                                        style: TextStyle(
                                            fontSize: 18/ MediaQuery.of(context).textScaleFactor,
                                            color:HexColor('#000'),
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                const Divider(thickness: 1.0, color: Colors.black),
                                InkWell(
                                  onTap: (){
                                    showLoaderDialog(context);
                                    setState(() {
                                      
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.color_lens_outlined,
                                        color:
                                        HexColor('#0E7289'),
                                        size: 35 * unitHeightValue,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        LanguageProvider.Llanguage('ChangeColor'),
                                        style: TextStyle(
                                            fontSize: 18/ MediaQuery.of(context).textScaleFactor,
                                            color:HexColor('#000'),
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                const Divider(thickness: 1.0, color: Colors.black),
                              //   GestureDetector(
                              //       onTap: () async {
                              //         showDialog(
                              //           context: context,
                              //           builder: (BuildContext context) {
                              //             return Expanded(
                              //               child: AlertDialog(
                              //                 title: Text(
                              //                     LanguageProvider.Llanguage('Logout'),
                              //                     style: TextStyle(
                              //                         fontSize: 18/ MediaQuery.of(context).textScaleFactor)),
                              //                 content: Text(
                              //                   LanguageProvider.Llanguage("txxt"),
                              //                   style: TextStyle(
                              //                       fontSize:
                              //                       18/ MediaQuery.of(context).textScaleFactor),
                              //                 ),
                              //                 actions: [
                              //                   TextButton(
                              //                     //  textColor: Colors.black,
                              //                     onPressed: () {
                              //                       final userPreference = Provider.of<UserViewModel>(context , listen: false);
                              //                         userPreference.remove();
                              //                       Navigator.pushNamed(context, RoutesName.login);
                              //                     },
                              //                     child: Text(
                              //                       LanguageProvider.Llanguage('Logout'),
                              //                       style: TextStyle(
                              //                           color: Colors.redAccent,
                              //                           fontSize: 18/ MediaQuery.of(context).textScaleFactor),
                              //                     ),
                              //                   ),
                              //                   TextButton(
                              //                     // textColor: Colors.black,
                              //                     onPressed: () {
                              //                       Navigator.of(context).pop();
                              //                     },
                              //                     child: Text(
                              //                       LanguageProvider.Llanguage('cancel'),
                              //                       style: TextStyle(
                              //                           color: Colors.black87,
                              //                           fontSize:  18/ MediaQuery.of(context).textScaleFactor),
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             );
                              //           },
                              //         );
                              //         //Widgets.ShowLoaderDialog(context, "Logout","");
                              //         /*Navigator.of(context).pushAndRemoveUntil(
                              // MaterialPageRoute(
                              //   builder: (context) => LoginScreen(),
                              // ),
                              //     (Route<dynamic> route) => false);*/
                              //       },
                              //       child: Row(
                              //         children: [
                              //           Icon(
                              //             Icons.logout_outlined,
                              //             color:HexColor('#000'),
                              //             size: 35 * unitHeightValue,
                              //           ),
                              //           const SizedBox(
                              //             width: 6,
                              //           ),
                              //           Text(
                              //             LanguageProvider.Llanguage('Logout'),
                              //             style: TextStyle(
                              //                 fontSize: 18/ MediaQuery.of(context).textScaleFactor,
                              //                 color: HexColor('#000'),
                              //                 fontWeight: FontWeight.w400),
                              //           )
                              //         ],
                              //       )),
                                   GestureDetector(
  onTap: () {
    CustomDialog.showYesNoDialog(
      context: context,
      title: LanguageProvider.Llanguage('Logout'),
      content: LanguageProvider.Llanguage('txxt'),
      yesButtonText: LanguageProvider.Llanguage('Logout'),
      noButtonText: LanguageProvider.Llanguage('cancel'),
      yesbuttoncolorbackground: ColorTheme(context),
      nobuttoncolorbackground: Colors.white,
      noButtonColortext: Colors.black,
      yesButtonColortext: Colors.white,
      Lottiepath: "assest/warning.json",
      blendMode: BlendMode.srcOver,
      fit: BoxFit.fill,
      onYesPressed: () async{
        final userPreference = Provider.of<UserViewModel>(context , listen: false);
        userPreference.remove();
    await  DatabaseHelper.updatename('');
        Navigator.pushNamed(context, RoutesName.login);
      },
      onNoPressed: () {
        Navigator.of(context).pop();
      },
    );
    
  },
  child: Row(
    children: [
      Icon(
        Icons.logout_outlined,
        color: HexColor('#000'),
        size: 35 * unitHeightValue,
      ),
      const SizedBox(
        width: 6,
      ),
      Text(
        LanguageProvider.Llanguage('Logout'),
        style: TextStyle(
          fontSize: 18 / MediaQuery.of(context).textScaleFactor,
          color: HexColor('#000'),
          fontWeight: FontWeight.w400,
        ),
      )
    ],
  ),
),
                                const SizedBox(
                                  height: 40,
                                ),
                                Align(
                                    alignment: LanguageProvider.Align(),
                                    child: Text(
                                      LanguageProvider.Llanguage("Feedback"),
                                      style: TextStyle(
                                          fontSize:  18/ MediaQuery.of(context).textScaleFactor,
                                          color:
                                          HexColor('#000'),
                                          fontWeight: FontWeight.w400),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.report_gmailerrorred,
                                      color:
                                      HexColor('#0E7289'),
                                      size: 35 * unitHeightValue,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      LanguageProvider.Llanguage("callus"),
                                      style: TextStyle(
                                          fontSize: 18/ MediaQuery.of(context).textScaleFactor,
                                          color:
                                          HexColor('#000'),
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                const Divider(thickness: 1.0, color: Colors.black),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.message_outlined,
                                    color: HexColor('#0E7289'),
                                    size: 35 * unitHeightValue,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    LanguageProvider.Llanguage("Sendfeedback"),
                                    style: TextStyle(
                                        fontSize: 18/ MediaQuery.of(context).textScaleFactor,
                                        color: HexColor('#000'),
                                        fontWeight: FontWeight.w500),
                                  )
                                ])
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            )),
      ]),
    );
  }


}
