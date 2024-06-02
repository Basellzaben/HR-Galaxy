// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names, deprecated_member_use
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/res/components/List_tile.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/Profie_Screen/widget/Tap_Controller.dart';
import 'package:mvvm/view_model/Home/HomeNew_View_Model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';
import 'package:provider/provider.dart';
import '../../../res/components/constants.dart';
import '../../../view_model/Profile/Profile_View_Model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {

    //x = MediaQuery.sizeOf(context).height * 0.1;
    //String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    //print(context.read<AuthViewModel>().UserName);
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    Map data = {
      'emp_No': context.read<AuthViewModel>().UserName,
      'id': LanguageProvider.getLanguage() == "AR" ? 0 : 1,
      'date': formattedDate,
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<ProfileViewModel>();
      viewModel.fetchGetProfileData(data, context);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<ProfileViewModel>();
      viewModel.fetchGetCalenderData(data, context);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<ProfileViewModel>();
      viewModel.fetchGetTimeLine(data, context);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<ProfileViewModel>();
      viewModel.fetchGetSalary(context.read<AuthViewModel>().UserName, context);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<ProfileViewModel>();
      viewModel.fetchGetBalanceData(data, context);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<ProfileViewModel>();
      viewModel.fetchGetTimeData(data, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sc = MediaQuery.of(context).textScaleFactor;
    var homeViewViewModel = context.read<HomeNewViewModel>();
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.homeHR, (Route<dynamic> route) => false);

          return false;
        },
        child: Directionality(
            textDirection: LanguageProvider.getDirection(),
            child: Scaffold(
                backgroundColor: ColorTheme(context),
                body: SingleChildScrollView(
                    child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        color: Colors.white,
                        child: Column(children: [
                          Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 35),
                                  width: MediaQuery.sizeOf(context).width / 1.2,
                                  child: AutoSizeText(
                                      LanguageProvider.Llanguage('profile'),
                                      maxLines: 2,
                                       style: TextStyle(
                                                    fontSize: 20 / sc,
                                                    fontWeight:
                                                        FontWeight.bold),)),
                            ],
                          ),
                          SizedBox(
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ClipRRect(
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
                                      padding: const EdgeInsets.all(0),
                                      child: homeViewViewModel.HomeData.data!
                                                  .list![0].imagePath! ==
                                              "-1"
                                          ? Image.asset(
                                           "assest/img.png",

                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: homeViewViewModel
                                                  .HomeData
                                                  .data!
                                                  .list![0]
                                                  .imagePath!,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Consumer<ProfileViewModel>(
                                  builder: (context, value, _) {
                                switch (value.ProfileData.status) {
                                  case Status.LOADING:
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  case Status.ERROR:
                                    return Center(
                                        child: Text(value.ProfileData.message
                                            .toString()));
                                  case Status.COMPLETED:
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        CustomProfileListTile(
                                          label:
                                              LanguageProvider.Llanguage('emp'),
                                          icons: Icons.person,
                                          showbutton: false,
                                          additionalInfo: value
                                              .ProfileData
                                              .data!
                                              .list![0]
                                              .employeeDisplayName!,
                                        ),
                                        CustomProfileListTile(
                                          label: LanguageProvider.Llanguage(
                                              'Email'),
                                          icons: Icons.email,
                                          showbutton: true,
                                          additionalInfo: value.ProfileData
                                              .data!.list![0].email!,
                                        ),
                                        CustomProfileListTile(
                                          label: LanguageProvider.Llanguage(
                                              'Directresponsible'),
                                          icons: FontAwesomeIcons.person,
                                          showbutton: false,
                                          additionalInfo: value.ProfileData
                                              .data!.list![0].managerName!,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomProfileListTile(
                                                label:
                                                    LanguageProvider.Llanguage(
                                                        'department'),
                                                icons:
                                                    FontAwesomeIcons.building,
                                                showbutton: false,
                                                additionalInfo: value
                                                    .ProfileData
                                                    .data!
                                                    .list![0]
                                                    .jobTitle!,
                                              ),
                                            ),
                                            // Phone Number
                                            Expanded(
                                              child: CustomProfileListTile(
                                                label:
                                                    LanguageProvider.Llanguage(
                                                        'Subdepartment'),
                                                icons: FontAwesomeIcons.hotel,
                                                showbutton: false,
                                                additionalInfo: value
                                                    .ProfileData
                                                    .data!
                                                    .list![0]
                                                    .employeeSectionDescription!,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomProfileListTile(
                                                label:
                                                    LanguageProvider.Llanguage(
                                                        'YearsofExperience'),
                                                icons:
                                                    FontAwesomeIcons.stopwatch,
                                                showbutton: false,
                                                additionalInfo: value
                                                    .ProfileData
                                                    .data!
                                                    .list![0]
                                                    .yearsOfExp!,
                                              ),
                                            ),
                                            // Phone Number
                                            Expanded(
                                              child: CustomProfileListTile(
                                                label:
                                                    LanguageProvider.Llanguage(
                                                        'Administration'),
                                                icons: FontAwesomeIcons
                                                    .magnifyingGlassChart,
                                                showbutton: false,
                                                additionalInfo: value
                                                    .ProfileData
                                                    .data!
                                                    .list![0]
                                                    .employeeDepartmentDescription!,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    );
                                  case null:
                                    break;
                                }
                                return Container();
                              }),
                              const TapController(),
                            ]),
                          ),
                        ]))))));
  }
}
