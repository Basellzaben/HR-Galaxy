import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/res/components/constants.dart';



class RoundButton extends StatelessWidget {

  final String title ;
  final bool loading ;
  final double fontSize;

  final VoidCallback onPress ;
  const RoundButton({Key? key ,
    required this.title,
    this.loading = false ,
     required this.onPress ,
    required this.fontSize,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ?(){}: onPress,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [ColorTheme(context), ColorTheme(context), ColorTheme(context)],),

          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
            child:loading ? CircularProgressIndicator(color: Colors.white,) :  Text(title ,
              style: TextStyle(color: AppColors.whiteColor,fontSize: fontSize),
            )),
      ),
    );
  }
}
