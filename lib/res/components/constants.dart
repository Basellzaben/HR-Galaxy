

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view_model/auth_view_model.dart';
import '../../view_model/services/LanguagePrvider.dart';



TextStyle kLoginTitleStyle(Size size) => GoogleFonts.ubuntu(
  fontSize: size.height * 0.060,
  fontWeight: FontWeight.bold,
);

TextStyle kLoginSubtitleStyle(Size size) => GoogleFonts.ubuntu(
  fontSize: size.height * 0.030,
);

TextStyle kLoginTermsAndPrivacyStyle(Size size) =>
    GoogleFonts.ubuntu(fontSize: 15, color: Colors.white, height: 1.5);

TextStyle kHaveAnAccountStyle(Size size) =>
    GoogleFonts.ubuntu(fontSize: size.height * 0.022, color: HexColor('#86166D'));

TextStyle kLoginOrSignUpTextStyle(
    Size size,
    ) =>
    GoogleFonts.ubuntu(
      fontSize: size.height * 0.022,
      fontWeight: FontWeight.w500,
      color: HexColor('#86166D'),
    );


Color greenColor = Color(0xff049B49);
Color redColor = Color(0xffE01F26);
Color appColor = Color(0xff9e2680);
Color unselColor = Color(0xffd8d9d9);

TextStyle kTextFormFieldStyle(context) =>  TextStyle(color: HexColor('#DE6EC5'),fontSize: 18/ MediaQuery.of(context).textScaleFactor);
TextStyle kTextFormFieldColor(context) =>  TextStyle(color: HexColor('#86166D'),fontSize: 18/ MediaQuery.of(context).textScaleFactor);
TextStyle TextFormFieldColor(context) =>  TextStyle(color: HexColor(Provider.of<Language>(context, listen: false).Color),fontSize: 20/ MediaQuery.of(context).textScaleFactor);
TextStyle TextFormFieldColor2(context) =>  TextStyle(color: HexColor('#0E7289'),fontSize: 18/ MediaQuery.of(context).textScaleFactor);
TextStyle TextFormFieldColor3(context) =>  TextStyle(color: HexColor('#0E7289'),fontSize: 18/ MediaQuery.of(context).textScaleFactor);
BorderSide SBorderside(context) =>BorderSide(color: HexColor(Provider.of<Language>(context, listen: false).Color) ,width: 1.5,);
 String them1="#229954";
 String basecolor="#86166D";
 String them2="#2E86C1";
 String them3="#8E44AD";
 String them4="#2E4053";
 String them5="#D35400";
 String them6="#c9a518";

HexColor ColorTheme(context) => HexColor(Provider.of<Language>(context,listen: false).Color);
HexColor ColorTheme3() => HexColor("86166D");
HexColor ColorTheme2(context) => HexColor(Provider.of<Language>(context).Color);

HexColor ColorWhite() => HexColor('#FFF');
HexColor ColorBlue() => HexColor('#0E7289');
TextStyle TextWhite() =>TextStyle(color: HexColor('#FFF'));
//HexColor ColorBlack() => HexColor('#000');
TextStyle ColorBlack(context) =>  TextStyle(color: HexColor('#000'), fontSize: 20 / MediaQuery.of(context).textScaleFactor);
TextStyle ColorBlack3(context) =>  TextStyle(color: HexColor('#000'), fontSize: 25/MediaQuery.of(context).textScaleFactor );
TextStyle ColorBlack5(context) =>  TextStyle(color: HexColor('#000'), fontSize: 15 );
TextStyle ColorThemeHdr(context) =>  TextStyle(color: HexColor(Provider.of<Language>(context).Color), fontSize: 18,fontWeight:FontWeight.bold );
TextStyle ColorBlack2(context) =>  TextStyle(color: HexColor('#000'), fontSize: 19 / MediaQuery.of(context).textScaleFactor);
TextStyle ColorBlack1(context) =>  TextStyle(color: HexColor('#000'), fontSize: 16,fontStyle:FontStyle.italic );
TextStyle ColorDay(context) =>  TextStyle(color: ColorTheme(context), fontSize: 35/ MediaQuery.of(context).textScaleFactor,fontWeight: FontWeight.bold ,height: 0);
TextStyle ColorDayTask(context) =>  TextStyle(color: HexColor('#000'), fontSize: 15,fontWeight: FontWeight.bold ,height: 0);
TextStyle ColorMonth(context) =>  TextStyle(color: HexColor('#000'), fontSize: 15,fontWeight: FontWeight.bold );
TextStyle ColorMonthTask(context) =>  TextStyle(color: ColorTheme(context), fontSize: 15,fontWeight: FontWeight.bold );
TextStyle ColorYear(context) =>  TextStyle(color: ColorTheme(context), fontSize: 10, );
TextStyle ColorYearTask(context) =>  TextStyle(color: HexColor('#000'), fontSize: 15, );
TextStyle ColorTime(context) =>  TextStyle(color: ColorTheme(context), fontSize:  15 ,fontWeight: FontWeight.bold );
TextStyle ColorTimeTask(context) =>  TextStyle(color: ColorTheme(context), fontSize: 10 );

Color getColor(BuildContext context ,  Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.selected,
    MaterialState.focused,
    MaterialState.pressed,
  };
  if (states.any(interactiveStates.contains)) {
    return ColorTheme(context);
  }
  return ColorWhite();



}

Widget textWidget(
    String text, double fontSize, FontWeight fontWeight, Color textColor) {
  return Text(
    text,
    style: GoogleFonts.montserrat(
        fontSize: fontSize, fontWeight: fontWeight, color: textColor),
  );
}
Widget textWidgetAligned(
    String text, double fontSize, FontWeight fontWeight, Color textColor,TextAlign textAlign) {
  return Text(
    text,
    textAlign: textAlign,
    style: GoogleFonts.montserrat(
        fontSize: fontSize, fontWeight: fontWeight, color: textColor),
  );
}

Widget fadedLine(String text, double fontSize,Context) {
  return SizedBox(
    height: 20,
    child: Stack(
      children: [
        Center(
            child:
            Image.asset("assest/linegray.png", width: double.infinity)),
        Center(child: textWidget(text, fontSize, FontWeight.w500,   ColorTheme(Context)))
      ],
    ),
  );
}

Widget rounedSquareContainer(
    double height, String text1, String text2, String text3, context) {
  return Container(
    height: height * 0.12,
    width: height * 0.12,
    decoration: BoxDecoration(

      borderRadius: const BorderRadius.all(
          Radius.circular(12)),
      border: Border.all(
        color: ColorTheme(context), // Border color
        width: 1.2, // Border width
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textWidget(text1, 14/MediaQuery.of(context).textScaleFactor, FontWeight.normal, ColorTheme(context)),
        textWidget(text2, 25/MediaQuery.of(context).textScaleFactor, FontWeight.w600, ColorTheme(context)),
        textWidget(text3, 14/MediaQuery.of(context).textScaleFactor, FontWeight.normal, ColorTheme(context))
      ],
    ),
  );
}

Widget requestsWidget(
    double height, double width, String imagePath, String requestText,double FontSize,Context) {
  return Column(
    children: [
      Image.asset(
        imagePath,
        width: width * 0.24,
        height: width * 0.24,
      ),
      SizedBox(
        height: height * 0.015,
      ),
      textWidget(requestText, FontSize, FontWeight.w600, ColorTheme(Context))
    ],
  );
}

Widget buttonBg(double width,double height,String text,Context){
  return Container(
    width: width,// Set the height to fill the available space
    height: height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft, // Define the start point of the gradient
        end: Alignment.centerRight, // Define the end point of the gradient
        colors: [
          ColorTheme(Context),
          ColorTheme(Context),
        ],
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: Center(child: textWidget(text, 14, FontWeight.w500, Colors.white)),
  );
}
Widget salarySlipItems(double width,String itemText,String suffixText,String baseText,bool itemSelected,context){
  return SizedBox(
    width: width*0.90,
    child: Row(
      children: [
        Container(
          width: width * 0.55,
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
          decoration: BoxDecoration(
              color: itemSelected ? ColorTheme(context) : unselColor,
              borderRadius: BorderRadius.circular(12)
          ),
          child: textWidget(itemText, 20/MediaQuery.of(context).textScaleFactor, FontWeight.w500, itemSelected ? Colors.white :Colors.black),
        ),
        SizedBox(width: width * 0.05,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            textWidget(suffixText, 17/MediaQuery.of(context).textScaleFactor, FontWeight.w500, itemSelected ? ColorTheme(context) : Colors.black),
            SizedBox(width: width * 0.01,),
            textWidget(baseText, 17/MediaQuery.of(context).textScaleFactor, FontWeight.w500, itemSelected ? ColorTheme(context) : Colors.black)
          ],
        )
      ],
    ),
  );
}


Widget salarySlipBottomItems(double width,double height,String title,String body){
  return Container(
    width:width * 0.41,
    height: height * 0.08,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius:
      const BorderRadius.all(Radius.circular(10)),
      border: Border.all(
        color: appColor, // Border color
        width: 1.2, // Border width
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(title, 11, FontWeight.w600, appColor),
        const SizedBox(height: 4,),
        textWidget(body, 9, FontWeight.w500, Colors.black)
      ],
    ),
  );
}

Widget radioItem(String title,bool isChecked){
  return Row(
    children: [
      Image.asset(
        isChecked ? "assest/circle_sel.png" : "assest/circle_unsel.png",
        width: 30,
        height: 30,
      ),
      const SizedBox(width: 8,),
      textWidget(title, 14, FontWeight.w500, Colors.black)
    ],
  );
}

List<String> monthItems = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
];


List<String> yearItems = [
  '2020',
  '2021',
  '2022',
  '2023',
  '2024',
  '2025',
  '2026',
];




showLoaderDialog(BuildContext context) {


  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,

      builder: (context) {
        return SizedBox(
          height: 320,
          child: Column(
            children: <Widget>
            [
              const SizedBox(height: 15,),
              Row(children: [


                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(Provider.of<Language>(context, listen: false).Llanguage('selectcolor'),

                          style: TextFormFieldColor(context)
                      )
                  ),
                ),

              ],),
              const Spacer(),

              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                      onTap: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString('them', basecolor.toString());
                        Provider.of<Language>(context , listen: false).setColor(basecolor.toString());
                        Navigator.pop(context);



                      }, child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: HexColor(basecolor.toString()),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100.0),
                          bottomRight: Radius.circular(100.0),
                          topLeft: Radius.circular(100.0),
                          bottomLeft: Radius.circular(100.0)),
                    ),
                  )),
                  const Spacer(),
                  GestureDetector(
                      onTap: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString('them', them1.toString());
                        Provider.of<Language>(context , listen: false).setColor(them1.toString());


                        Navigator.pop(context);

                      }, child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color:HexColor(them1.toString()),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100.0),
                          bottomRight: Radius.circular(100.0),
                          topLeft: Radius.circular(100.0),
                          bottomLeft: Radius.circular(100.0)),
                    ),
                  )),
                  const Spacer(),
                  GestureDetector(
                      onTap: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString('them', them2.toString());
                        Provider.of<Language>(context , listen: false).setColor(them2.toString());

                        Navigator.pop(context);

                      }, child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: HexColor(them2.toString()),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100.0),
                          bottomRight: Radius.circular(100.0),
                          topLeft: Radius.circular(100.0),
                          bottomLeft: Radius.circular(100.0)),
                    ),
                  )),
                  const Spacer(),
                ],
              ),
              const Spacer(),

              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                      onTap: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString('them', them3.toString());
                        Provider.of<Language>(context , listen: false).setColor(them3.toString());

                        Navigator.pop(context);


                      }, child:Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: HexColor(them3.toString()),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100.0),
                          bottomRight: Radius.circular(100.0),
                          topLeft: Radius.circular(100.0),
                          bottomLeft: Radius.circular(100.0)),
                    ),
                  )),
                  const Spacer(),
                  GestureDetector(
                      onTap: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString('them', them4.toString());
                       Provider.of<Language>(context , listen: false).setColor(them4.toString());

                        Navigator.pop(context);

                      }, child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: HexColor(them4.toString()),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100.0),
                          bottomRight: Radius.circular(100.0),
                          topLeft: Radius.circular(100.0),
                          bottomLeft: Radius.circular(100.0)),
                    ),
                  )),
                  const Spacer(),
                  GestureDetector(
                      onTap: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString('them', them5.toString());
                        Provider.of<Language>(context , listen: false).setColor(them5.toString());

                        Navigator.pop(context);

                      },  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: HexColor(them5.toString()),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100.0),
                          bottomRight: Radius.circular(100.0),
                          topLeft: Radius.circular(100.0),
                          bottomLeft: Radius.circular(100.0)),
                    ),
                  )),
                  const Spacer()
                ],
              ),
              const Spacer(),
              context.read<AuthViewModel>().UserName==23?
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                      onTap: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString('them', them6.toString());
                        Provider.of<Language>(context , listen: false).setColor(them6.toString());

                        Navigator.pop(context);


                      }, child:Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: HexColor(them6.toString()),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100.0),
                          bottomRight: Radius.circular(100.0),
                          topLeft: Radius.circular(100.0),
                          bottomLeft: Radius.circular(100.0)),
                    ),
                  )),

                ],
              ):
              const Spacer(),

            ]

            ,
          ),
        );
      });


}






