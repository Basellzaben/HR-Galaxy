import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvvm/res/components/constants.dart';

// ignore: must_be_immutable
class CustomProfileListTile extends StatelessWidget {
  final String label;
  final IconData icons;
  final Function()? onTap;
  var showbutton;
  final String? additionalInfo;

  CustomProfileListTile({
    Key? key,
    required this.label,
    required this.icons,
    this.onTap,
    this.showbutton = true,
    this.additionalInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textsc = MediaQuery.of(context).textScaleFactor;
    // ignore: deprecated_member_use
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        
        height: MediaQuery.of(context).size.height * 0.1,
        // margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorTheme(context),
          ),
          // color: ColorTheme(context).withOpacity(0.1),
        ),
      
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 2.0),
          leading: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FaIcon(
              icons,
              color: ColorTheme(context),
            ),
          ),
         
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AutoSizeText(
              
                                        label,
                                        minFontSize: 5,
                                        maxLines: 1,
                                         style: TextStyle(
                                                      fontSize: 17 / textsc,
                                                      color: ColorTheme(context),
                                                      fontWeight:
                                                          FontWeight.bold),),
          ),
          onTap: onTap,
          trailing: showbutton == true
              ? MaterialButton(
                  minWidth: 35,
                  height: 35,
                  onPressed: () async {
                    await Clipboard.setData(
                        ClipboardData(text: additionalInfo!));
                    Fluttertoast.showToast(
                      msg: "copiedToClipboard",
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Theme.of(context).colorScheme.background,
                      textColor: Theme.of(context).colorScheme.onBackground,
                    );
                  },
                  child: const Icon(Icons.copy),
                )
              : (showbutton == false
                  ? null
                  : MaterialButton(
                      minWidth: 35,
                      height: 35,
                      onPressed: () {},
                      child: const Icon(Icons.edit),
                    )),
          subtitle: additionalInfo == null
              ? null
              :SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: AutoSizeText(
    additionalInfo!,
    minFontSize: 5,
    wrapWords: true,
    maxLines: 1,
    style: TextStyle(
      fontSize: 17 / textsc,
      fontWeight: FontWeight.w700
    ),
  ),
)
              
              
           
                
        ),
      ),
    );
  }
}

class CustomInputDecoration {
  static InputDecoration getDecoration({
    required BuildContext context,
    String? hintText,
    String? labelText,
    //  required Them ThemP,
    required double textScaleFactor,
    Color? color,
  }) {
    return InputDecoration(
      fillColor: Colors.blue,
      hintText: hintText,
      labelText: labelText,
      floatingLabelAlignment: FloatingLabelAlignment.center,
      labelStyle: TextStyle(
        color: color ?? Colors.black,
        fontSize:  18/textScaleFactor ,
      ),
      hintStyle: TextStyle(
        fontSize:  20/textScaleFactor,
        color: Colors.black,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorTheme(context)),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorTheme(context)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      errorStyle: const TextStyle(color: Colors.red),
    );
  }
}

class CustomInputDecoration1 {
  static Widget showDecoration({
    required BuildContext context,
    String? hintText,
    String? labelText,
    required double textScaleFactor,
    Color? color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hint Text: $hintText',
            style: TextStyle(
              color: color ?? Colors.black,
              fontSize: textScaleFactor * 20,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Label Text: $labelText',
            style: TextStyle(
              color: color ?? Colors.black,
              fontSize: textScaleFactor * 20,
            ),
          ),
        ],
      ),
    );
  }
}
