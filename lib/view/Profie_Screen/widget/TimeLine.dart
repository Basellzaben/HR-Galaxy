// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/res/components/constants.dart';
import 'package:mvvm/view_model/Profile/Profile_View_Model.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimeLineWidgetState createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
      const double minFontSize = 8.0;
                const double defaultFontSize = 15.0;

                // Calculate the adjusted font size
                double adjustedFontSize = defaultFontSize / MediaQuery.of(context).textScaleFactor;
                if (adjustedFontSize < minFontSize) {
                  adjustedFontSize = minFontSize;
                }
    // ignore: deprecated_member_use
    var viewModel = Provider.of<ProfileViewModel>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 70, bottom: 70),
      child: Timeline.tileBuilder(
        theme: TimelineThemeData(
          color: ColorTheme(context),
          indicatorTheme: const IndicatorThemeData(
            color: Colors.black,
            size: 20.0,
          ),
          connectorTheme: const ConnectorThemeData(
            thickness: 2.5,
          ),
        ),
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        builder: TimelineTileBuilder.fromStyle(
            contentsAlign: ContentsAlign.alternating,
            indicatorStyle: IndicatorStyle.outlined,
            // oppositeContentsBuilder: (context, index) => Padding(
            //   padding: const EdgeInsets.all(24.0),
            //   child: Text("${viewModel.TimeLineData.data!.list![index].descrip!} (${DateFormat('yyyy-MM-dd').format(DateTime.parse(viewModel.TimeLineData.data!.list![index].curdates!)
            //    )})"),
            // ),
            connectorStyle: ConnectorStyle.dashedLine,
            contentsBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    maxLines: 2,
                    style: TextStyle(
                      fontSize:adjustedFontSize,
                    
                    ),
                    
                    
                      "${viewModel.TimeLineData.data!.list![index].descrip!} (${DateFormat('yyyy-MM-dd').format(DateTime.parse(viewModel.TimeLineData.data!.list![index].curdates!))})"),
                ),
            itemCount: viewModel.TimeLineData.data!.list!.length,
            endConnectorStyle: ConnectorStyle.solidLine),
      ),
    );
  }
}
