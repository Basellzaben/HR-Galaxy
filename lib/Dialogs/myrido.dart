import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/components/constants.dart';
import '../view_model/Vacations/Vacations_view_model.dart';
import '../view_model/services/LanguagePrvider.dart';

enum BestTutorSite {  w3schools, tutorialandexample }

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  BestTutorSite _site = BestTutorSite.tutorialandexample;

  Widget build(BuildContext context) {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    return Directionality(
      textDirection: LanguageProvider.getDirection(),
      child: Container(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          /*  Container(
              width: MediaQuery.sizeOf(context).width /3,
              child: ListTile(
                title:  Text(LanguageProvider.Llanguage('All')),
                contentPadding: const EdgeInsets.all(0),
                leading: Radio(
                  value: BestTutorSite.javatpoint,
                  groupValue: _site,
                  onChanged: (BestTutorSite? value) {
                    setState(() {
                      _site = value!;
                    });
                  },
                ),
              ),
            ),*/
            Container(
              width: MediaQuery.sizeOf(context).width /2.4,
              child: ListTile(
                title:  Text(LanguageProvider.Llanguage('finished'),style: TextStyle(fontSize: 23/MediaQuery.of(context).textScaleFactor),),
                contentPadding: const EdgeInsets.all(0),

                leading:  Transform.scale(
                scale: 2,
                child: Radio(
                  activeColor: ColorTheme(context),
                  hoverColor: ColorTheme(context),
                    value: BestTutorSite.w3schools,
                    groupValue: _site,
                    visualDensity: VisualDensity(
                      horizontal: VisualDensity.maximumDensity,
                      vertical: VisualDensity.maximumDensity,
                    ),
                    onChanged: (BestTutorSite? value) {
                      setState(() {
                        _site = value!;
                        context.read<Vacationsviewmodel>()
                            .setVacationstates(
                            (1),
                            LanguageProvider.Llanguage('finished'));
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width /2,
              child: ListTile(
                title:  Text(LanguageProvider.Llanguage('Notfinished'),style: TextStyle(fontSize: 23/MediaQuery.of(context).textScaleFactor)),
                contentPadding: const EdgeInsets.all(0),
                leading:  Transform.scale(
                scale: 2,
                  child: Radio(
                    value: BestTutorSite.tutorialandexample,
                    groupValue: _site,
                    activeColor: ColorTheme(context),
                    hoverColor: ColorTheme(context),
                    onChanged: (BestTutorSite? value) {
                      setState(() {
                        _site = value!;
                        context.read<Vacationsviewmodel>()
                            .setVacationstates(
                            (2),
                            LanguageProvider.Llanguage('Notfinished'));
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
