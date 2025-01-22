// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mvvm/view/Profie_Screen/widget/Calender_Date.dart';
import 'package:mvvm/view/Profie_Screen/widget/LineChart.dart';
import 'package:mvvm/view/Profie_Screen/widget/Permanency_status.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';
import 'package:provider/provider.dart';

class TapController extends StatefulWidget {
  const TapController({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TapControllerWidgetState createState() => _TapControllerWidgetState();
}

class _TapControllerWidgetState extends State<TapController> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var LanguageProvider = Provider.of<Language>(context);
    final fontSize = 20 / textScaleFactor;

    return DefaultTabController(
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            tabAlignment: TabAlignment.start,
            physics: const BouncingScrollPhysics(),
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.redAccent,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.grey,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w100,
              fontSize: fontSize,
              fontStyle: FontStyle.italic,
            ),
            tabs: [
              Tab(
                child: Text(LanguageProvider.Llanguage("WorkingStatus"),
                    style: TextStyle(
                      // fontFamily: ArabicFont.aalooBhaijaan,
                      package: 'google_fonts_arabic',
                      fontSize: fontSize,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Tab(
                child: Text(LanguageProvider.Llanguage("empcalender"),
                    style: TextStyle(
                      // fontFamily: ArabicFont.aalooBhaijaan,
                      package: 'google_fonts_arabic',
                      fontSize: fontSize,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Tab(
                child: Text(LanguageProvider.Llanguage("TimeLine"),
                    style: TextStyle(
                      // fontFamily: ArabicFont.aalooBhaijaan,
                      package: 'google_fonts_arabic',
                      fontSize: fontSize,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Tab(
                child: Text(
                  LanguageProvider.Llanguage("salary"),
                  style: TextStyle(
                    // fontFamily: ArabicFont.aalooBhaijaan,
                    package: 'google_fonts_arabic',
                    fontSize: fontSize,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child:  TabBarView(
              children: [
                const PermanencyStatus(),
                const MyDatePickerWidget(),
                //const TimeLine(),
                MyChartWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
