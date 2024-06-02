import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/Vacations/Vacations_view_model.dart';
import '../view_model/services/LanguagePrvider.dart';

enum BestTutorSite {  w3schools, tutorialandexample }

class INOUTDailog extends StatefulWidget {
  INOUTDailog({Key? key}) : super(key: key);

  @override
  _INOUTDailogState createState() => _INOUTDailogState();
}

class _INOUTDailogState extends State<INOUTDailog> {
  BestTutorSite _site = BestTutorSite.w3schools;

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
              width: MediaQuery.sizeOf(context).width /2,
              child: ListTile(
                title:  Text(LanguageProvider.Llanguage('inpass')),
                contentPadding: const EdgeInsets.all(0),

                leading: Radio(
                  value: BestTutorSite.w3schools,
                  groupValue: _site,
                  onChanged: (BestTutorSite? value) {
                    setState(() {
                      _site = value!;
                      context.read<Vacationsviewmodel>()
                          .setINOUT(
                          (0),
                          LanguageProvider.Llanguage('inpass'));
                    });
                  },
                ),
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width /2,
              child: ListTile(
                title:  Text(LanguageProvider.Llanguage('outpass')),
                contentPadding: const EdgeInsets.all(0),
                leading: Radio(
                  value: BestTutorSite.tutorialandexample,
                  groupValue: _site,
                  onChanged: (BestTutorSite? value) {
                    setState(() {
                      _site = value!;
                      context.read<Vacationsviewmodel>()
                          .setINOUT(
                          (1),
                          LanguageProvider.Llanguage('outpass'));
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
