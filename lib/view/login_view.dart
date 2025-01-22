// ignore_for_file: await_only_futures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mvvm/res/components/constants.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/Dialogs/custom_dialog.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import '../view_model/services/GlobalVal.dart';
import '../view_model/services/LanguagePrvider.dart';

Widget dialogBody(BuildContext context, TextEditingController note) {
  var LanguageProvider = Provider.of<Language>(context, listen: false);
  return Directionality(
    textDirection: LanguageProvider.getDirection(),
    child: WillPopScope(
      onWillPop: ()async{
          String ipAddress = await DatabaseHelper.getIP();

        if (ipAddress.isEmpty) {
          Utils.flushBarErrorMessage("Please enter IP Address", context);
          return Future.value(false);
        } else {
          Navigator.of(context).pop();
          return Future.value(true);
        }
      },
      child: Column(
        children: [
          Text(
            LanguageProvider.Llanguage("PleaseEnterIP"),
            style: TextFormFieldColor(context),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .01),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: TextFormField(
              controller: note,
              style: ColorBlack(context),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: SBorderside(context),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                hintText: LanguageProvider.Llanguage("IpAddress"),
                labelText: LanguageProvider.Llanguage("IpAddress"),
                hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor * 18,
                    color: ColorTheme(context),
                    fontWeight: FontWeight.w400),
                labelStyle: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor * 18,
                    color: ColorTheme(context),
                    fontWeight: FontWeight.w400),
                enabledBorder: OutlineInputBorder(
                  borderSide: SBorderside(context),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  var check = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    //homeViewViewModel.fetchMoviesListApi();

    super.initState();

    var LanguageProvider = Provider.of<Language>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //  BottomSheetExample();
      String ip = await DatabaseHelper.getIP();
      TextEditingController _NOte = TextEditingController();
      if (ip == "") {
        // await DatabaseHelper.updateIP("http://94.249.83.196:9072");

        await CustomDialog.showDoneDialog(
           title: LanguageProvider.Llanguage("IpAddress"),
          context: context, //
          barrierDismissible: false,
          body: dialogBody(context, _NOte),
          doneButtonText: LanguageProvider.Llanguage("SaveIP"),
           onDonePressed: () async {
             if (_NOte.text.isEmpty) {
               Utils.flushBarErrorMessage(
                  LanguageProvider.Llanguage("PleaseEnterIP"), context);
            } else {
               String noteText = _NOte.text;
              await DatabaseHelper.updateIP(noteText);
               Navigator.of(context).pop();
             }
           },
         );
      }
    }
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final fontSize = 25.0;

    final height = MediaQuery.of(context).size.height * 1;

    var LanguageProvider = Provider.of<Language>(context, listen: false);
    return Directionality(
      textDirection: LanguageProvider.getDirection(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.width / 1.3,
                        child: Image.asset(
                          "assest/logo.png",
                          width: MediaQuery.sizeOf(context).width / 1.5,
                          height: MediaQuery.sizeOf(context).height / 1.8,
                        )),
                    Positioned(
                      top: 25,
                      left: 0,
                      child: InkWell(
                        onTap: () async {
                           String ip = await DatabaseHelper.getIP();
                          TextEditingController _NOte =
                              TextEditingController(text:ip );
                          TextEditingController _password =
                              TextEditingController();
                          String password = 1234.toString();
                          await CustomDialog.showDoneDialog(
                            title: LanguageProvider.Llanguage("password"),
                            context: context, //
                            barrierDismissible:
                              ip.isEmpty ? false : true,
                            body: Directionality(
                              textDirection: LanguageProvider.getDirection(),
                              child: Column(
                                children: [
                                  Text(
                                    LanguageProvider.Llanguage("knowpassword"),
                                    style: TextFormFieldColor(context),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height * .008),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(
                                        left: 30, right: 30, top: 20),
                                    child: TextFormField(
                                      controller: _password,
                                      style: ColorBlack(context),
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: SBorderside(context),
                                          borderRadius:
                                              const BorderRadius.all(Radius.circular(15)),
                                        ),
                                        hintText:
                                            LanguageProvider.Llanguage("password"),
                                        labelText:
                                            LanguageProvider.Llanguage("password"),
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .textScaleFactor *
                                                18,
                                            color: ColorTheme(context),
                                            fontWeight: FontWeight.w400),
                                        labelStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .textScaleFactor *
                                                18,
                                            color: ColorTheme(context),
                                            fontWeight: FontWeight.w400),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: SBorderside(context),
                                          borderRadius:
                                              const BorderRadius.all(Radius.circular(15)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            doneButtonText: LanguageProvider.Llanguage("gotoip"),
                            onDonePressed: () async {
                              String ip = await DatabaseHelper.getIP();
                              if (password == _password.text.toString()) {
                                Navigator.of(context).pop();
                                await CustomDialog.showDoneDialog(
                                  title: LanguageProvider.Llanguage("IpAddress"),
                                  context: context, //
                                  barrierDismissible:
                                     ip.isEmpty ? false : true,
                                  body: dialogBody(context, _NOte),
                                  doneButtonText:
                                      LanguageProvider.Llanguage("SaveIP"),
                                  onDonePressed: () async {
                                    if (_NOte.text.isEmpty) {
                                      Utils.flushBarErrorMessage(
                                          LanguageProvider.Llanguage(
                                              "PleaseEnterIP"),
                                          context);
                                    } else {
                                      String noteText = _NOte.text;
                                      await DatabaseHelper.updateIP(noteText);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                );
                              } else {
                                Utils.flushBarErrorMessage(
                                    LanguageProvider.Llanguage("wrongpassword"),
                                    context);
                              }
                            },
                          );
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: ColorTheme(context),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30, top: 0),
                      child: TextFormField(
                        style: ColorBlack3(context),
        
                        decoration: InputDecoration(
                          /*   prefixIcon: Icon(Icons.person),*/
                          focusedBorder: OutlineInputBorder(
                            borderSide: SBorderside(context),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                          ),
                          hintText: LanguageProvider.Llanguage('username'),
                          labelText: LanguageProvider.Llanguage('username'),
                          hintStyle: ColorBlack3(context),
                          labelStyle: ColorBlack3(context),
                          enabledBorder: OutlineInputBorder(
                            borderSide: SBorderside(context),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        controller: _emailController,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          } else if (value.length < 0) {
                            return 'at least enter 4 characters';
                          } else if (value.length > 13) {
                            return 'maximum character is 13';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * .025,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: ValueListenableBuilder(
                          valueListenable: _obsecurePassword,
                          builder: (context, value, child) {
                            return TextFormField(
                              style: ColorBlack3(context),
                              controller: _passwordController,
                              obscureText: _obsecurePassword.value,
                              focusNode: passwordFocusNode,
                              obscuringCharacter: "*",
                              decoration: InputDecoration(
                                /*   prefixIcon: Icon(Icons.person),*/
                                hintText: LanguageProvider.Llanguage('password'),
                                labelText: LanguageProvider.Llanguage('password'),
                                labelStyle: ColorBlack3(context),
                                hintStyle: ColorBlack3(context),
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
                                      const BorderRadius.all(Radius.circular(15)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: SBorderside(context),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: height * .025,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: RoundButton(
                        title: LanguageProvider.Llanguage('login'),
                        fontSize: fontSize / textScaleFactor,
                        loading: authViewMode.loading,
                        onPress: () {
                          
                          if (_emailController.text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                'Please enter Username', context);
                          } else if (_passwordController.text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                'Please enter Password', context);
                          } else {
                            Map data = {
                              'Username':
                                  int.parse(_emailController.text.toString()),
                              'Password': _passwordController.text.toString(),
                              'NewPassword': "0",
                            };
        
                            // Map data = {
                            //   'email' : 'eve.holt@reqres.in',
                            //   'password' : 'cityslicka',
                            // };
        
                            authViewMode.loginApi(data, check, context);
                            print('api hit');
                          }
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
                          child: Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                   MaterialStateProperty.resolveWith(
          (states) => getColor(context, states),
                                   ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              value: check,
                              onChanged: (bool? value) async {
                                setState(() {
                                  check = !check;
                                  //Provider.of<LoginProvider>(context, listen: false).setRemember(check);
                                  //   saveREstate(check.toString());
                                });
                              }),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 0, right: 0, top: 15),
                          child: Text(
                            LanguageProvider.Llanguage('RememberMe'),
                            maxLines: 2,
                            style:
                                TextStyle(fontSize: fontSize / textScaleFactor),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * .025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        ColorTheme(context),
                                        ColorTheme(context),
                                        ColorTheme(context)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  width: 75,
                                  height: 75,
                                  child: const Icon(
                                    Icons.fingerprint,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                )),
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: 150,
                            margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
                            child: Text(
                              LanguageProvider.Llanguage('finger'),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: fontSize / textScaleFactor),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: height * .025,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Powered By",
                                style: ColorBlack3(context),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                child: Image.asset(
                                  "assest/logo4.png",
                                  height: 25,
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
    MaterialStateProperty<Color?> myBackgroundColor(Color color) {
  return MaterialStateProperty.all<Color?>(color);
}
}
