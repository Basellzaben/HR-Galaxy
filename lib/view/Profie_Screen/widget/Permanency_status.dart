// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/Dialogs/custom_dialog.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/res/components/List_tile.dart';
import 'package:mvvm/res/components/constants.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/view_model/Profile/Profile_View_Model.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';
import 'package:provider/provider.dart';

class PermanencyStatus extends StatefulWidget {
  const PermanencyStatus({super.key});

  @override
  _PermanencyStatusWidgetState createState() => _PermanencyStatusWidgetState();
}

class _PermanencyStatusWidgetState extends State<PermanencyStatus> {
  DateTime? _selectedDate = DateTime.now();
  String M = DateFormat('MM').format(DateTime.now());
  String y = DateFormat('yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var LanguageProvider = Provider.of<Language>(context);
    final fontSize = 20 / textScaleFactor;

    return Padding(
      padding: const EdgeInsets.only(top: 2, left: 8, right: 8, bottom: 0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: InputDecorator(
                    decoration: CustomInputDecoration.getDecoration(
                        context: context,
                        textScaleFactor: textScaleFactor,
                        labelText: LanguageProvider.Llanguage('reqDate'),
                        hintText: LanguageProvider.Llanguage('reqDate')),
                    child: Center(
                        child: InkWell(
                      onTap: () async {
                        await CustomDialog.showDoneDialog(
                          title: LanguageProvider.Llanguage("PlzSelectDate"),
                          context: context, //
                          // barrierDismissible:
                          // ip.isEmpty ? false : true,
                          body: Directionality(
                              textDirection: LanguageProvider.getDirection(),
                              child: Container(
                                height: 150,
                                width: 150,
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: DatePickerWidget(
                                  looping: false, // default is not looping
                                  firstDate: DateTime(2000, 01, 01),
                                  lastDate: DateTime(2050, 1, 1),
                                  initialDate: _selectedDate == null
                                      ? DateTime(int.parse(y), int.parse(M), 1)
                                      : _selectedDate,

                                  dateFormat: "MM-yyyy",
                                  locale: DatePicker.localeFromString('en'),
                                  onChange: (DateTime newDate, _) {
                                    _selectedDate = newDate;
                                    print(_selectedDate!);
                                  },

                                  pickerTheme: DateTimePickerTheme(
                                    itemTextStyle: ColorMonthTask(context),
                                    dividerColor: ColorTheme(context),
                                  ),
                                ),
                              )),
                          doneButtonText: LanguageProvider.Llanguage("Back"),
                          onDonePressed: () async {
                            setState(() {});
                            Navigator.pop(context);
                          },
                        );
                      },
                      child: Center(
                        child: Text(
                          DateFormat('yyyy-MM').format(_selectedDate!),
                          style: TextStyle(
                              fontSize: fontSize, color: Colors.black),
                        ),
                      ),
                    )),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: RoundButton(
                    title: LanguageProvider.Llanguage('sendrequest'),
                    loading: false,
                    fontSize: 15,
                    onPress: () {
                      String M1 = DateFormat('MM').format(_selectedDate!);
                      String y1 = DateFormat('yyyy').format(_selectedDate!);
                      String d = "30";

                      Map data = {
                        'emp_No': context.read<AuthViewModel>().UserName,
                        'id': LanguageProvider.getLanguage() == "AR" ? 0 : 1,
                        'date': y1 + "-" + M1 + "-" + d,
                      };

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        final viewModel = context.read<ProfileViewModel>();
                        viewModel.fetchGetTimeData(data, context);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          
          Consumer<ProfileViewModel>(
            builder: (context, value, _) {
              switch (value.LineData.status) {
                case Status.LOADING:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.ERROR:
                  return Center(
                    child: Text(value.LineData.message.toString()),
                  );
                case Status.COMPLETED:
                  return Expanded(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: value.LineData.data!.list == null
                          ? 0
                          : value.LineData.data!.list!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (MediaQuery.of(context).orientation ==
                                      Orientation.portrait)
                                  ? 2
                                  : 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 3.4),
                      itemBuilder: (BuildContext context, int index) {
                        return InputDecorator(
                          textAlignVertical: TextAlignVertical.bottom,
                          textAlign: TextAlign.center,
                          baseStyle: TextStyle(
                              fontSize: fontSize, color: Colors.black),
                          isHovering: true,
                          isFocused: true ,
                          isEmpty: true,

                          decoration: CustomInputDecoration.getDecoration(
                            color: ColorTheme(context),
                              context: context,
                              textScaleFactor: textScaleFactor,
                              labelText: value
                                  .LineData.data!.list![index].subjectDesc!,
                              hintText:  value.LineData.data!.list![index].recCount!,),
                        
                        );
                      },
                    ),
                  );
                case null:
                  break;
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

}
