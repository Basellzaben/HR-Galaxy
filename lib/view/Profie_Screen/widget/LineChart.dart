import 'package:flutter/material.dart';
import 'package:mvvm/res/components/constants.dart';
import 'package:mvvm/view_model/Profile/Profile_View_Model.dart';
import 'package:mvvm/view_model/services/LanguagePrvider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

class MyChartWidget extends StatefulWidget {
  @override
  State<MyChartWidget> createState() => _MyChartWidgetState();
}

class _MyChartWidgetState extends State<MyChartWidget> {
  @override
  List<ChartData> chartDataList = [];

  void initState() {
    super.initState();
    var profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);
    chartDataList = profileViewModel.SalaryData.data!.list!
        .map((e) => ChartData(
            int.parse(e.subjectID!.split('.')[0]), double.parse(e.recCount!)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var LanguageProvider = Provider.of<Language>(context);
    return  Center(
        child: Container(
          color: Colors.white,
          height: 300, // Adjust the height as needed
          child: Consumer<ProfileViewModel>(
            builder: (context, viewModel, _) => 
            viewModel.SalaryData.data!.list!.isEmpty
                ? Center(
                    child: Text(
                      LanguageProvider.Llanguage('NoData'),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    )
                  )
                :
            SfCartesianChart(
              plotAreaBorderColor: ColorTheme(context),
              borderColor:ColorTheme(context) ,
              backgroundColor: Colors.white,
              primaryXAxis: CategoryAxis(),
              series: <CartesianSeries>[
                // Renders line chart
                LineSeries<ChartData, int>(
                  color: ColorTheme(context),
                  dataSource: chartDataList,
                  // dataSource: viewModel.SalaryData.data!.list!
                  //     .map((e) => ChartData(int.parse(e.subjectID!) , double.parse(e.recCount!)))
                  //     .toList(),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                )
              ],
            ),
          ),
        ),
     
    );
  }
}
