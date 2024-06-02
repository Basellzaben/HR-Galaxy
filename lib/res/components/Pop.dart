

import 'package:flutter/material.dart';
import 'package:mvvm/view_model/Vacations/Vacations_view_model.dart';

class showpop extends StatefulWidget{
const showpop({Key? key}) : super(key: key);

@override
_showpopState createState() => _showpopState();
}

class _showpopState extends State<showpop> {

  Vacationsviewmodel  vacationsviewmodel = Vacationsviewmodel();

  @override
  void initState() {
    // TODO: implement initState
    Map data = {
      'EmployeeNo': '10',
    };
    vacationsviewmodel.fetchVacationsTypeList(data,context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          contentPadding: EdgeInsets.only(
            top: 10.0,
          ),
          title: Text(
            "Create ID",
            style: TextStyle(fontSize: 24.0),
          ),
          content: Container(
            height: 400,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Mension Your ID ",
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Id here',
                          labelText: 'ID'),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        // fixedSize: Size(250, 50),
                      ),
                      child: Text(
                        "Submit",
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Note'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt'
                          ' ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud'
                          ' exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                          ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum '
                          'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,'
                          ' sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );



  }


}
