import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/res/components/constants.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/MyRequest_View_Model/My_Request_ViewModel.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';
import '../view_model/user_view_model.dart';

class ChangePassword_Dialog extends StatefulWidget {
  const ChangePassword_Dialog({Key? key}) : super(key: key);

  @override
  _ChangePassword_DialogState createState() => _ChangePassword_DialogState();
}

class _ChangePassword_DialogState extends State<ChangePassword_Dialog> {
  My_Request_ViewModel vacationsviewmodel = My_Request_ViewModel();
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> _obsecurePassword1 = ValueNotifier<bool>(true);
  ValueNotifier<bool> _obsecurePassword2 = ValueNotifier<bool>(true);
  var check = false;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordController1 = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode passwordFocusNode1 = FocusNode();
  FocusNode passwordFocusNode2 = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();


    _passwordController.dispose();
    _passwordController1.dispose();
    _passwordController2.dispose();

    passwordFocusNode.dispose();
    passwordFocusNode2.dispose();
    passwordFocusNode1.dispose();

    _obsecurePassword.dispose();
    _obsecurePassword1.dispose();
    _obsecurePassword2.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState

/*
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<My_Request_ViewModel>();
      viewModel.fetchTaskDatadetails(data, context);
    });
*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final authViewMode = Provider.of<AuthViewModel>(context);
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final fontSize = 20 / textScaleFactor;
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
                  'Gangepasswor'),
              textAlign: TextAlign.center,
              style: TextFormFieldColor(context),
            ),
            content: Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: Scaffold(body:


                     SingleChildScrollView(
                      child: Column(

                        children: [

                          SizedBox(
                            height: height * .025,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                            child: ValueListenableBuilder(
                                valueListenable: _obsecurePassword,
                                builder: (context, value, child) {
                                  return TextFormField(
                                    style: ColorBlack(context),
                                    controller: _passwordController,
                                    obscureText: _obsecurePassword.value,
                                    focusNode: passwordFocusNode,
                                    obscuringCharacter: "*",
                                    decoration: InputDecoration(
                                      /*   prefixIcon: Icon(Icons.person),*/
                                      hintText: LanguageProvider.Llanguage(
                                          'oldpassword'),
                                      labelText: LanguageProvider.Llanguage(
                                          'oldpassword'),
                                      labelStyle: ColorBlack(context),
                                      hintStyle: ColorBlack(context),
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            _obsecurePassword.value =
                                            !_obsecurePassword.value;
                                          },
                                          child: Icon(
                                            _obsecurePassword.value
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility,
                                            color: ColorTheme(context),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: SBorderside(context),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: SBorderside(context),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: height * .025,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                            child: ValueListenableBuilder(
                                valueListenable: _obsecurePassword1,
                                builder: (context, value, child) {
                                  return TextFormField(
                                    style: ColorBlack(context),
                                    controller: _passwordController1,
                                    obscureText: _obsecurePassword1.value,
                                    focusNode: passwordFocusNode1,
                                    obscuringCharacter: "*",
                                    decoration: InputDecoration(
                                      /*   prefixIcon: Icon(Icons.person),*/
                                      hintText: LanguageProvider.Llanguage(
                                          'Newpassword'),
                                      labelText: LanguageProvider.Llanguage(
                                          'Newpassword'),
                                      labelStyle: ColorBlack(context),
                                      hintStyle: ColorBlack(context),
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            _obsecurePassword1.value =
                                            !_obsecurePassword1.value;
                                          },
                                          child: Icon(
                                            _obsecurePassword1.value
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility,
                                            color: ColorTheme(context),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: SBorderside(context),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: SBorderside(context),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: height * .025,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                            child: ValueListenableBuilder(
                                valueListenable: _obsecurePassword2,
                                builder: (context, value, child) {
                                  return TextFormField(
                                    style: ColorBlack(context),
                                    controller: _passwordController2,
                                    obscureText: _obsecurePassword2.value,
                                    focusNode: passwordFocusNode2,
                                    obscuringCharacter: "*",
                                    decoration: InputDecoration(
                                      /*   prefixIcon: Icon(Icons.person),*/
                                      hintText: LanguageProvider.Llanguage(
                                          'confirmpassword'),
                                      labelText: LanguageProvider.Llanguage(
                                          'confirmpassword'),
                                      labelStyle: ColorBlack(context),
                                      hintStyle: ColorBlack(context),
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            _obsecurePassword2.value =
                                            !_obsecurePassword2.value;
                                          },
                                          child: Icon(
                                            _obsecurePassword2.value
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility,
                                            color: ColorTheme(context),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: SBorderside(context),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: SBorderside(context),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                      ),
                                    ),
                                  );
                                }),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.bottomLeft,
                            child: RoundButton(
                              title:  LanguageProvider.Llanguage(
                                  'changePass'),
                              loading: authViewMode.loading,
                              fontSize:fontSize ,
                              onPress: () {
                          if(_passwordController1.text.toString()!=_passwordController2.text.toString())
                            {
                                Utils.flushBarErrorMessage(LanguageProvider.Llanguage(
                                    'MSG'),context);

                            }
                          else
                            {

                                Map data = {
                                  'Username':context.read<AuthViewModel>().UserName,
                                  'Password': _passwordController.text.toString(),
                                  'NewPassword': _passwordController1.text.toString(),
                                };

                                // Map data = {
                                //   'email' : 'eve.holt@reqres.in',
                                //   'password' : 'cityslicka',
                                // };

                                authViewMode.ChangeLogin(data,LanguageProvider.getLanguage(), context);
                              }}
                            ),
                          ),
                        ],
                      ),

                     )
            ),
            ),
          )),
    );
  }
}
