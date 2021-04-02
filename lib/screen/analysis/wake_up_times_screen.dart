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
          offset: Offset(-15, -50),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            child: SfCartesianChart(
              // X軸の設定
              primaryXAxis: CategoryAxis(title: AxisTitle()),

              // Y軸の設定
              primaryYAxis: NumericAxis(minimum: 3),

              // グラフの説明
              legend: Legend(isVisible: true),

              // グラフを選択した時のメニュー
              tooltipBehavior: TooltipBehavior(
                enable: true,
                format: 'point.x：point.y時起',
              ),

              // グラフをトラックした時の縦線
              trackballBehavior: TrackballBehavior(
                enable: true,
                tooltipSettings: InteractiveTooltip(
                  enable: true,
                  color: Colors.red,
                ),
              ),

              // グラフデータ
              series: <LineSeries<WakeUpTime, String>>[
                LineSeries<WakeUpTime, String>(
                  name: '起床時間',
                  dataSource: postNtf.wakeUpTimes,
                  xValueMapper: (WakeUpTime wakeUpTimes, _) => wakeUpTimes.label.toString(),
                  yValueMapper: (WakeUpTime wakeUpTimes, _) => wakeUpTimes.time,
                  sortFieldValueMapper: (WakeUpTime wakeUpTimes, _) => wakeUpTimes.reportAt,
                  sortingOrder: SortingOrder.ascending,
                  dataLabelSettings: DataLabelSettings(isVisible: false), // グラフ上の数字
                ),
                LineSeries<WakeUpTime, String>(
                  name: '平均',
                  dataSource: postNtf.wakeUpTimes
                      .map((wakeUpTime) => WakeUpTime(
                            wakeUpTime.label,
                            postNtf.averageWakeUpTimes,
                            wakeUpTime.reportAt,
                          ))
                      .toList(),
                  xValueMapper: (WakeUpTime wakeUpTimes, _) => wakeUpTimes.label.toString(),
                  yValueMapper: (WakeUpTime wakeUpTimes, _) => wakeUpTimes.time,
                  sortFieldValueMapper: (WakeUpTime wakeUpTimes, _) => wakeUpTimes.reportAt,
                  sortingOrder: SortingOrder.ascending,
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
