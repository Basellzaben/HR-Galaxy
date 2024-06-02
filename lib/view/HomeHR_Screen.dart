// ignore_for_file: library_private_types_in_public_api, unused_field, use_build_context_synchronously

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/Home/HomeNew_View_Model.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';
import 'package:provider/provider.dart';

import '../Dialogs/custom_dialog.dart';
import '../res/components/constants.dart';
import '../view_model/services/GlobalVal.dart';

class HomeHRScreen extends StatefulWidget {
  const HomeHRScreen({Key? key}) : super(key: key);

  @override
  _HomeHRScreenState createState() => _HomeHRScreenState();
}

class _HomeHRScreenState extends State<HomeHRScreen> {
  String cont = "0";
  Uint8List? imageData;
  bool _isEnabled = true;
  HomeNewViewModel homeViewViewModel = HomeNewViewModel();
  String? _currentAddress;
  Position? _currentPosition;
  ScrollController? scrollController;
  bool scrollVisible = true;

  Future<String?> _getId() async {
    // var deviceInfo = DeviceInfoPlugin();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }
    return null;
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Clear();
    // convertHexToUint8List();
    setState(() {
      GloablVal.User = context.read<AuthViewModel>().UserName;
      print(GloablVal.User);
    });
    Future.microtask(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<Vacationsviewmodel>().setINOUT((1), '');
      });
    });

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController!.position.userScrollDirection ==
            ScrollDirection.forward);
      });
    //x = MediaQuery.sizeOf(context).height * 0.1;
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print(context.read<AuthViewModel>().UserName);
    var LanguageProvider1 = Provider.of<Language>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<Vacationsviewmodel>()
          .setINOUT1(-1, LanguageProvider1.Llanguage('outpass'));
    });

    Map data = {
      'EmployeeNo': context.read<AuthViewModel>().UserName,
      'StartDate': currentDate.toString(),
    };
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<HomeNewViewModel>();
      viewModel.getHomeData(data, LanguageProvider1.getLanguage(), context);
    });
    bool check = false;
    super.initState();
  }

  // void convertHexToUint8List() {
  //   try {
  //     Uint8List bytes =
  //         Uint8List.fromList(HEX.decode(imge!.replaceAll("0x", "")));

  //     setState(() {
  //       imageData = bytes;
  //     });
  //   } catch (e) {
  //     print("Error converting hex to Uint8List: $e");
  //   }
  // }

  void setDialVisible(bool value) {
    setState(() {
      scrollVisible = value;
    });
  }

  void Clear() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Vacationsviewmodel>().setVacationsTypeName("");
      context.read<Vacationsviewmodel>().setEmpalternative(0, "");
      context.read<Vacationsviewmodel>().setVacationsShowType(0);
    });
  }

  double width = 0;
  double height = 0;
  double statusBarHeight = 0;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    statusBarHeight = MediaQuery.of(context).padding.top;
    double? x = 0.00122 * MediaQuery.of(context).size.height;
    /* String? imge ="0x89504E470D0A1A0A0000000D4948445200000435000004380802000000968C7068000000097048";
    Uint8List bytes = Uint8List.fromList(HEX.decode(imge));
    Uint8List? imageData;

    setState(() {
      imageData = bytes;
    });*/
    // var vacationsViewModel = Provider.of<Vacationsviewmodel>(context, listen: false);

    double sc = MediaQuery.of(context).textScaleFactor;
    final ViewMode = Provider.of<HomeNewViewModel>(context);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        exit(0);

        return false;
      },
      child: Directionality(
        textDirection: LanguageProvider.getDirection(),
        child: Scaffold(
            backgroundColor: ColorTheme(context),
            body: Consumer2<HomeNewViewModel, Vacationsviewmodel>(
                builder: (context, value, vaction, _) {
              switch (value.HomeData.status) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(child: Text(value.HomeData.message.toString()));
                case Status.COMPLETED:
                  var arr = value.HomeData.data!.list![0].sS1!.split(' ');
                  var arr1 = value.HomeData.data!.list![0].ss!.split(' ');
                  cont = value.HomeData.data!.list![0].countTask!;
                  if (value.HomeData.data!.list![0].imagePath! != "-1") {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      vaction.setImage_Path(
                          value.HomeData.data!.list![0].imagePath!);
                    });
                  }
                  if (int.parse(value.HomeData.data!.list![0].letastAct!) ==
                      0) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      vaction.setINOUT(
                          (1), LanguageProvider.Llanguage('outpass'));
                      vaction.setOutdialog("Confirmfingerprintexit");
                    });
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      vaction.setINOUT(
                          (0), LanguageProvider.Llanguage('inpass'));
                      vaction.setOutdialog("Confirmfingerprintentry");
                    });
                  }
                  return SafeArea(
                      child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorTheme(context),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(0),
                                        child: value.HomeData.data!.list![0]
                                                    .imagePath! ==
                                                "-1"
                                            ? Image.asset(
                                                "assest/img.png",
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ): CachedNetworkImage(
                                                imageUrl: value.HomeData.data!
                                                    .list![0].imagePath!,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 0),
                                      child: AutoSizeText(
                                        LanguageProvider.getLanguage() == 'AR'
                                            ? value.HomeData.data!.list![0]
                                                .arabicName!
                                            : value.HomeData.data!.list![0]
                                                .englishName!,
                                        style: TextStyle(
                                          fontSize: 25 /
                                              MediaQuery.of(context)
                                                  .textScaleFactor,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RoutesName.notifications_screen,
                                      );
                                    },
                                    child: value.HomeData.data!.list![0]
                                                .countWar! !=
                                            "0"
                                        ? Badge(
                                            label: Text(
                                              value.HomeData.data!.list![0]
                                                  .countWar!,
                                              style: TextStyle(
                                                fontSize: 20 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.notifications,
                                              color: ColorTheme(context),
                                              size: 30,
                                            ),
                                          )
                                        : Icon(
                                            Icons.notifications,
                                            color: ColorTheme(context),
                                            size: 30,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 0, right: 0, top: 5, bottom: 5),
                                child: SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).width / 2.5,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          CustomDialog.showYesNoDialog(
                                            context: context,
                                            title: LanguageProvider.Llanguage(
                                                'timeimprint'),
                                            content: LanguageProvider.Llanguage(
                                                vaction.INOUT1 != -1
                                                    ? vaction.Indialog
                                                    : vaction.Outdialog),
                                            yesButtonText:
                                                LanguageProvider.Llanguage(
                                                    'confirm'),
                                            noButtonText:
                                                LanguageProvider.Llanguage(
                                                    'cancel'),
                                            yesbuttoncolorbackground:
                                                ColorTheme(context),
                                            nobuttoncolorbackground:
                                            Colors.white,
                                            heightlottei: 150,
                                            widthlottei: 150,
                                            colorlottei: ColorTheme(context),
                                            noButtonColortext: Colors.black,
                                            blendMode: BlendMode.color,
                                            yesButtonColortext: Colors.white,
                                            Lottiepath: "assest/fingerprint1.json",
                                            onYesPressed: () async {
                                              if (_isEnabled) {
                                                await _getCurrentPosition();
                                                String? deviceId =
                                                    await _getId();
                                                String? x = "0";
                                                if (int.parse(value
                                                        .HomeData
                                                        .data!
                                                        .list![0]
                                                        .letastAct!) ==
                                                    1) {
                                                  x = "0";
                                                } else {
                                                  x = "1";
                                                }
                                                context
                                                    .read<HomeNewViewModel>()
                                                    .setData(
                                                        _currentPosition!
                                                            .latitude
                                                            .toString(),
                                                        _currentPosition!
                                                            .longitude
                                                            .toString(),
                                                        deviceId,
                                                        x);
                                                Map data = {
                                                  'empNo': context
                                                      .read<AuthViewModel>()
                                                      .UserName,
                                                  'actionNo': vaction.INOUT1 ==
                                                          -1
                                                      ? vaction.INOUT.toString()
                                                      : vaction.INOUT1.toString(),
                                                  'coor_X': context
                                                      .read<HomeNewViewModel>()
                                                      .lat,
                                                  'coor_Y': context
                                                      .read<HomeNewViewModel>()
                                                      .long,
                                                  'tabletName': context
                                                      .read<HomeNewViewModel>()
                                                      .ID,
                                                };

                                                WidgetsBinding.instance!
                                                    .addPostFrameCallback((_) {
                                                  ViewMode.GetCheckInOut(
                                                      data, context);
                                                  if (ViewMode
                                                          .CheckINO.status ==
                                                      Status.COMPLETED) {
                                                    String currentDate =
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(
                                                                DateTime.now());
                                                    print(context
                                                        .read<AuthViewModel>()
                                                        .UserName);

                                                    Map data = {
                                                      'EmployeeNo': context
                                                          .read<AuthViewModel>()
                                                          .UserName,
                                                      'StartDate': currentDate
                                                          .toString(),
                                                    };

                                                    final viewModel =
                                                        context.read<
                                                            HomeNewViewModel>();
                                                    viewModel.getHomeData(
                                                        data,
                                                        LanguageProvider
                                                            .getLanguage(),
                                                        context);
                                                    _isEnabled = !_isEnabled;
                                                  }
                                                });
                                                /*     context
                                                .read<Vacationsviewmodel>()
                                                .setINOUT((0), "");*/
                                              } else {
                                                // Code for else block
                                              }
                                            },
                                            onNoPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          );
                                          //
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width /
                                                3.3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  //<-- SEE HERE
                                                  width: 1,
                                                  color: ColorTheme(context)),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(20),
                                              child: !ViewMode.loading
                                                  ? SvgPicture.asset(
                                                      "assest/fingerprint.svg",
                                                      semanticsLabel:
                                                          'Acme Logo',
                                                      color:
                                                          ColorTheme(context),
                                                      fit: BoxFit.contain,
                                                    )
                                                  : Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                            ),
                                            height: MediaQuery.sizeOf(context)
                                                    .width /
                                                3,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                13,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 0, right: 0, top: 3),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: sc >= 1.75
                                                  ? (MediaQuery.sizeOf(context)
                                                          .width /
                                                      11)
                                                  : (MediaQuery.sizeOf(context)
                                                          .width /
                                                      11),
                                              child: AutoSizeText(
                                                LanguageProvider.Llanguage(
                                                    'todayattendance'),
                                                style: TextStyle(
                                                    fontSize: 20 / sc,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),

                                              /*    SizedBox(
                                                height: (MediaQuery.sizeOf(context)
                                                            .width /
                                                        10) ,

                                                child: value.HomeData.data!.list![0]
                                                            .sS2 ==
                                                        "1"
                                                    ? Container(
                                                        child: AutoSizeText(
                                                          LanguageProvider.Llanguage(
                                                              'ontime'),
                                                          style: TextStyle(
                                                              color: Colors.green,
                                                              fontSize: 15 *x/
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .textScaleFactor),
                                                          textAlign: TextAlign.left,
                                                        ),
                                                      )
                                                    : Container(
                                                        child: AutoSizeText(
                                                          LanguageProvider.Llanguage(
                                                              'delay'),
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 15 *x),
                                                          textAlign: TextAlign.left,
                                                        ),
                                                      )),*/
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    value.HomeData.data!
                                                                .list![0].sS2 ==
                                                            "0"
                                                        ? textWidget(
                                                            int.parse(value
                                                                        .HomeData
                                                                        .data!
                                                                        .list![
                                                                            0]
                                                                        .letastAct!) ==
                                                                    1
                                                                ? arr1[0]
                                                                    .toString()
                                                                : arr[0]
                                                                    .toString(),
                                                            25 / sc,
                                                            FontWeight.w800,
                                                            greenColor)
                                                        : textWidget(
                                                            int.parse(value
                                                                        .HomeData
                                                                        .data!
                                                                        .list![
                                                                            0]
                                                                        .letastAct!) ==
                                                                    1
                                                                ? arr1[0]
                                                                    .toString()
                                                                : arr[0]
                                                                    .toString(),
                                                            25 / sc,
                                                            FontWeight.w800,
                                                            redColor),
                                                    value.HomeData.data!
                                                                .list![0].sS2 ==
                                                            "0"
                                                        ? textWidget(
                                                            int.parse(value
                                                                        .HomeData
                                                                        .data!
                                                                        .list![
                                                                            0]
                                                                        .letastAct!) ==
                                                                    1
                                                                ? arr1[1]
                                                                    .toString()
                                                                : arr[1]
                                                                    .toString(),
                                                            25 / sc,
                                                            FontWeight.w800,
                                                            greenColor)
                                                        : textWidget(
                                                            int.parse(value
                                                                        .HomeData
                                                                        .data!
                                                                        .list![
                                                                            0]
                                                                        .letastAct!) ==
                                                                    1
                                                                ? arr1[1]
                                                                    .toString()
                                                                : arr[1]
                                                                    .toString(),
                                                            25 / sc,
                                                            FontWeight.w800,
                                                            redColor),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: width * 0.025,
                                                ),
                                                SizedBox(
                                                  width: 70,
                                                  height: 70,
                                                  child: Stack(
                                                    children: [
                                                      Image.asset(
                                                        value
                                                                    .HomeData
                                                                    .data!
                                                                    .list![0]
                                                                    .sS2 ==
                                                                "0"
                                                            ? "assest/ok2.png"
                                                            : "assest/notok2.png",
                                                        width: 70,
                                                        height: 70,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (vaction.INOUT1 == -1) {
                                                  vaction.setINOUT1(
                                                      vaction.INOUT,
                                                      vaction.INOUTName);
                                                  print(
                                                      vaction.INOUT.toString() +
                                                          "ss");
                                                  vaction.setIndialog(
                                                      "Confirmfingerprintentry");
                                                }

                                                if (vaction.INOUT1 == 0) {
                                                  vaction.setINOUT1(
                                                      1,
                                                      LanguageProvider
                                                          .Llanguage(
                                                              'outpass'));
                                                  vaction.setIndialog(
                                                      "Confirmfingerprintexit");
                                                } else {
                                                  vaction.setINOUT1(
                                                      0,
                                                      LanguageProvider
                                                          .Llanguage('inpass'));
                                                  vaction.setIndialog(
                                                      "Confirmfingerprintentry");
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  textWidget(
                                                      LanguageProvider.Llanguage(
                                                              'nextaction') +
                                                          " : ",
                                                      20 / sc,
                                                      FontWeight.w500,
                                                      ColorTheme(context)),
                                                  textWidget(
                                                      vaction.INOUT1 == -1
                                                          ? vaction.INOUTName
                                                          : vaction.INOUTName1,
                                                      17 / sc,
                                                      FontWeight.w500,
                                                      Colors.black),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.sizeOf(context).width,
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  textWidget(
                                      LanguageProvider.Llanguage('supposed') +
                                          " : ",
                                      18 / sc,
                                      FontWeight.w500,
                                      ColorTheme(context)),
                                  textWidget(
                                      value.HomeData.data!.list![0].tTime!,
                                      18 / sc,
                                      FontWeight.w500,
                                      Colors.black),
                                ],
                              ),
                            ),
                            Container(
                                width: MediaQuery.sizeOf(context).width,
                                height: MediaQuery.sizeOf(context).width / 11,
                                margin: EdgeInsets.only(left: 25, right: 25),
                                child: fadedLine(
                                    LanguageProvider.Llanguage('vacations'),
                                    20 / sc,
                                    context)),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 25, right: 25, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  rounedSquareContainer(
                                      height,
                                      LanguageProvider.Llanguage('sick'),
                                      value.HomeData.data!.list![0]
                                          .empBalanceSick!,
                                      LanguageProvider.Llanguage('Days'),
                                      context),
                                  rounedSquareContainer(
                                      height,
                                      LanguageProvider.Llanguage('annual'),
                                      value.HomeData.data!.list![0].empBalance!,
                                      LanguageProvider.Llanguage('Days'),
                                      context),
                                  rounedSquareContainer(
                                      height,
                                      LanguageProvider.Llanguage('leave'),
                                      value
                                          .HomeData.data!.list![0].empSumLeave!,
                                      LanguageProvider.Llanguage('Hours'),
                                      context),
                                ],
                              ),
                            ),

                            Container(
                                width: MediaQuery.sizeOf(context).width,
                                height: MediaQuery.sizeOf(context).width / 10,
                                margin: EdgeInsets.only(left: 25, right: 25),
                                child: fadedLine(
                                    LanguageProvider.Llanguage('Requests1'),
                                    20 / sc,
                                    context)),

                            Container(
                              margin: EdgeInsets.only(left: 25, right: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          RoutesName.MyRequestScreen,
                                          (Route<dynamic> route) => false);
                                    },
                                    child: requestsWidget(
                                        height,
                                        width,
                                        "assest/my_requests1.png",
                                        LanguageProvider.Llanguage('Request') +
                                            "(" +
                                            value.HomeData.data!.list![0]
                                                .countMyRequest! +
                                            ")",
                                        15 / sc,
                                        context),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          RoutesName.LeaveScreen,
                                          (Route<dynamic> route) => false);
                                    },
                                    child: requestsWidget(
                                        height,
                                        width,
                                        "assest/leave1.png",
                                        LanguageProvider.Llanguage('leave'),
                                        15 / sc,
                                        context),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          RoutesName.VacatlonScreen,
                                          (Route<dynamic> route) => false);
                                    },
                                    child: requestsWidget(
                                        height,
                                        width,
                                        "assest/vacation1.png",
                                        LanguageProvider.Llanguage('vac'),
                                        15 / sc,
                                        context),
                                  ),
                                ],
                              ),
                            ),
                            //////////////////////////////////////////////////////////////////
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 25, right: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          RoutesName.task_screen,
                                          (Route<dynamic> route) => false);
                                    },
                                    child: requestsWidget(
                                        height,
                                        width,
                                        "assest/request1.png",
                                        LanguageProvider.Llanguage('task') +
                                            " (" +
                                            value.HomeData.data!.list![0]
                                                .countTask! +
                                            ")",
                                        15 / sc,
                                        context),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          RoutesName.AttendanceScreen,
                                          (Route<dynamic> route) => false);
                                    },
                                    child: requestsWidget(
                                        height,
                                        width,
                                        "assest/attendance1.png",
                                        LanguageProvider.Llanguage(
                                            'workingstate'),
                                        15 / sc,
                                        context),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          RoutesName.SalaryslipScreen,
                                          (Route<dynamic> route) => false);
                                    },
                                    child: requestsWidget(
                                        height,
                                        width,
                                        "assest/salary_icon1.png",
                                        LanguageProvider.Llanguage(
                                            'Salaryslip'),
                                        15 / sc,
                                        context),
                                  ),
                                ],
                              ),
                            ),
                            //////////////////////////////////////////////////////////////////
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
              }
              return Container();
            })),
      ),
    );
  }
}
