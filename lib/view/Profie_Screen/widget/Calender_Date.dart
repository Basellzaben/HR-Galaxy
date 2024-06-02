// ignore_for_file: file_names, non_constant_identifier_names
import 'package:auto_size_text/auto_size_text.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/model/Profile/GetCalenderModel.dart';
import 'package:mvvm/view_model/Profile/Profile_View_Model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';
import 'package:provider/provider.dart';

class MyDatePickerWidget extends StatefulWidget {
  const MyDatePickerWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDatePickerWidgetState createState() => _MyDatePickerWidgetState();
}

class _MyDatePickerWidgetState extends State<MyDatePickerWidget> {
  late List<DateTime?> _multiDatePickerValueWithDefaultValue;
  @override
  void initState() {
    super.initState();
    _multiDatePickerValueWithDefaultValue = [
      DateTime.now(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var LanguageProvider = Provider.of<Language>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, top: 50, bottom: 8),
      child: Column(
        children: [
          Row(
            //Create Custumoize to show the color of the date
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 40,
                  color: rgbToColor("#40acbf"),
                  child: Center(
                      child: AutoSizeText(
                        minFontSize: 5,
                    LanguageProvider.Llanguage("vac"),
                    style: TextStyle(
                      fontSize:  14/textScaleFactor,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 40,
                  color: rgbToColor("#da302d"),
                  child: Center(
                      child: AutoSizeText(
                        minFontSize: 5,
                    LanguageProvider.Llanguage("leave"),
                    style: TextStyle(
                      fontSize:  14/textScaleFactor,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 40,
                  color: rgbToColor("#bf5299"),
                  child: Center(
                      child: AutoSizeText(
                        minFontSize: 5,
                    LanguageProvider.Llanguage("OfficialTasks"),
                    style: TextStyle(
                      fontSize:  14/textScaleFactor,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 40,
                  color: rgbToColor("#56963c"),
                  child: Center(
                      child: AutoSizeText(
                    LanguageProvider.Llanguage("Birthdays"),
                    minFontSize: 5,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize:  14/textScaleFactor,
                      
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 40,
                  color: rgbToColor("#ceaa57"),
                  child: Center(
                      child: AutoSizeText(
                        minFontSize: 5,
                                            LanguageProvider.Llanguage("documents"),
                                            maxLines: 2,
                                            style: TextStyle(
                        fontSize:  14/textScaleFactor,
                        
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                                            ),
                      )),
                ),
              ),
            ],
          ),
          Consumer<ProfileViewModel>(builder: (context, value, _) {
            switch (value.ProfileData.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(
                    child: Text(value.ProfileData.message.toString()));
              case Status.COMPLETED:
                return CalendarDatePicker2(
                  
                    config: CalendarDatePicker2Config(
                      
                      controlsHeight: 40,
                      calendarType: CalendarDatePicker2Type.single,
                      dayBuilder: ({
                        required DateTime date,
                        BoxDecoration? decoration,
                        bool? isDisabled,
                        bool? isSelected,
                        bool? isToday,
                        TextStyle? textStyle,
                      }) {
                        GetCalender? dayModel =
                            value.CalenderData.data?.list?.firstWhere(
                          (model) => DateTime.parse(model.startingDate!)
                              .isAtSameMomentAs(date),
                          orElse: () => GetCalender(colorType: ""),
                        );
                        if (dayModel?.colorType != null &&
                            dayModel!.colorType!.isNotEmpty) {
                          Color dayColor = rgbToColor(dayModel.colorType!);
                          return Container(
                            decoration: BoxDecoration(
                              color: dayColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:  14/textScaleFactor,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return null;
                        }
                      },
                    ),
                    value: _multiDatePickerValueWithDefaultValue,
                    
                    onDisplayedMonthChanged: (value) async {
                      var now = value;
                      var formatter = DateFormat('yyyy-MM-dd');
                      String formattedDate = formatter.format(now);
                      Map data = {
                        'emp_No': context.read<AuthViewModel>().UserName,
                        'id': LanguageProvider.getLanguage() == "AR" ? 0 : 1,
                        'date': formattedDate,
                      };
                      final viewModel = context.read<ProfileViewModel>();
                      await viewModel.fetchGetCalenderData(data, context);

                    },
                    // onValueChanged: (value) {
                    //   // print(value.toString());
                    //   _multiDatePickerValueWithDefaultValue = [DateTime.now()];
                    //   print(_multiDatePickerValueWithDefaultValue);
                    // }
                    );

              default:
                return const SizedBox();
            }
          }),
        ],
      ),
    );
  }

  Color rgbToColor(String rgbCode) {
    if (rgbCode.isEmpty) return Colors.transparent;

    if (rgbCode.contains("rgb")) {
      // Removing "rgb(" and ")" from the string
      String trimmedCode = rgbCode.replaceAll("rgb(", "").replaceAll(")", "");

      // Splitting the RGB values by comma
      List<String> rgbValues = trimmedCode.split(',');

      if (rgbValues.length != 3) return Colors.transparent;

      int red = int.parse(rgbValues[0].trim());
      int green = int.parse(rgbValues[1].trim());
      int blue = int.parse(rgbValues[2].trim());

      return Color.fromRGBO(
          red, green, blue, 1); // Creating Color object with RGB values
    } else if (rgbCode.contains("#")) {
      String code = rgbCode;
      String hexCode = code.replaceAll("#", "");
      if (hexCode.length == 6) {
        hexCode = "FF$hexCode"; // Adding alpha value for opaque color
      }
      return Color(int.parse(hexCode, radix: 16));
    }
    // return Color(int.parse(rgbCode.replaceAll("#", "0xFF")));
    else {
      return Colors.transparent;
    }
  }
}
