import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/components/MenuItem.dart';
import 'package:mvvm/res/components/constants.dart';
import 'package:mvvm/view/HomeHR_Screen.dart';
import 'package:mvvm/view/Profie_Screen/View/Profile_Screen.dart';
import 'package:mvvm/view/Settings_Screen.dart';

import 'Salaryslip_Screen.dart';


  class HomeNew extends StatefulWidget {
  const HomeNew({Key? key}) : super(key: key);

  @override
  _HomeNewState createState() => _HomeNewState();
  }

class _HomeNewState extends State<HomeNew>{

  final MenuItemList = const<MenuItem>[
    MenuItem(Icons.settings, ""),
    MenuItem(Icons.home, ""),

    MenuItem(Icons.person_rounded, ""),
  ];
  int index=1;
  final _buildBody =const <Widget>[Settings(),HomeHRScreen(),ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        // إعادة false لتعطيل زر الرجوع
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: SizedBox(
      
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
      
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            currentIndex: index,
            onTap: (value) {
              // Respond to item press.
              setState(() {
                index=value;
              });
            }, items: MenuItemList.map((MenuItem menuItem) => BottomNavigationBarItem(icon: Icon(menuItem.iconDatal),backgroundColor: ColorTheme(context),label: menuItem.text,)).toList(),
      
            ),
        ),body: _buildBody[index]),
    );
  }

}