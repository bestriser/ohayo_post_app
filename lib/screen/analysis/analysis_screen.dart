import 'package:flutter/material.dart';
import 'package:ohayo_post_app/model/wake_up_time.dart';
import 'package:ohayo_post_app/notifier/post_notifier.dart';
import 'package:ohayo_post_app/utility/convert.dart';
import 'package:ohayo_post_app/widget/posting_floating_action_button.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postNtf = Provider.of<PostNotifier>(context);
    final posts = postNtf.posts
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    final wakeUpTimes = posts
        .map((post) => WakeUpTime(Convert().getMonthDayWeekDay(post.createdAt),
            Convert().getHourMinute(post.createdAt)))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('分析')),
      floatingActionButton: PostingFloatingActionButton(),
      body: Center(
        child: Transform.translate(
          offset: Offset(0, -60),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: '起床時間'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <LineSeries<WakeUpTime, String>>[
                LineSeries<WakeUpTime, String>(
                    dataSource: wakeUpTimes,
                    xValueMapper: (WakeUpTime wakeUpTimes, _) =>
                        wakeUpTimes.label.toString(),
                    yValueMapper: (WakeUpTime wakeUpTimes, _) =>
                        wakeUpTimes.time,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
