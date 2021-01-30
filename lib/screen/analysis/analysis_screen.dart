import 'package:flutter/material.dart';
import 'package:ohayo_post_app/widget/posting_floating_action_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('ねこ', 5),
      ChartData('お父さん', 8),
      ChartData('お母さん', 4),
      ChartData('ぼく', 2)
    ];

    return Scaffold(
      appBar: AppBar(title: Text('分析')),
      floatingActionButton: PostingFloatingActionButton(),
      body: Center(
        child: Container(
          child: SfPyramidChart(
            title: ChartTitle(text: '家庭内権力図'),
            palette: <Color>[
              Colors.orange[300],
              Colors.orange[200],
              Colors.orange[100],
              Colors.orange[50]
            ],
            tooltipBehavior: TooltipBehavior(enable: true),
            legend: Legend(isVisible: true),
            series: PyramidSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
