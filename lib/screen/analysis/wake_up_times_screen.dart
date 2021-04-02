import 'package:flutter/material.dart';
import 'package:ohayo_post_app/model/wake_up_time.dart';
import 'package:ohayo_post_app/notifier/person_notifier.dart';
import 'package:ohayo_post_app/notifier/post_notifier.dart';
import 'package:ohayo_post_app/widget/posting_floating_action_button.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WakeUpTimesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postNtf = Provider.of<PostNotifier>(context);
    final personNtf = Provider.of<PersonNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text('${personNtf.person.nickName}さんの起床時間')),
      floatingActionButton: PostingFloatingActionButton(),
      body: Center(
        child: Transform.translate(
          offset: Offset(0, -70),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              legend: Legend(isVisible: true), // グラフの説明
              tooltipBehavior: TooltipBehavior(enable: true), // グラフを選択した時のメニュー
              series: <LineSeries<WakeUpTime, String>>[
                LineSeries<WakeUpTime, String>(
                  name: '起床時間',
                  dataSource: postNtf.wakeUpTimes,
                  xValueMapper: (WakeUpTime wakeUpTimes, _) => wakeUpTimes.label.toString(),
                  yValueMapper: (WakeUpTime wakeUpTimes, _) => wakeUpTimes.time,
                  dataLabelSettings: DataLabelSettings(isVisible: true), // グラフ上の数字
                ),
                LineSeries<WakeUpTime, String>(
                  name: '平均',
                  dataSource:
                      postNtf.wakeUpTimes.map((wakeUpTime) => WakeUpTime(wakeUpTime.label, postNtf.averageWakeUpTimes)).toList(),
                  xValueMapper: (WakeUpTime wakeUpTimes, _) => wakeUpTimes.label.toString(),
                  yValueMapper: (WakeUpTime wakeUpTimes, _) => wakeUpTimes.time,
                  dataLabelSettings: DataLabelSettings(isVisible: false), // グラフ上の数字
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
