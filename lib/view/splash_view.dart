import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm/res/components/constants.dart';
import 'package:mvvm/view_model/services/splash_services.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    splashServices.checkAuthentication(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color: ColorWhite(),
        child: Center(
          child: Image.asset(
            "assest/logo.png",
            width: MediaQuery.sizeOf(context)
                .width /
                1.5,
              height: MediaQuery.sizeOf(context)
                  .height /
                  1.8,
             )
        ),
      ),
    );
  }
}
