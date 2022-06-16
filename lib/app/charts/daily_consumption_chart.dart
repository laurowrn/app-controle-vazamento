import 'package:app/app/charts/daily_consumption_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyConsumptionChart extends StatelessWidget {
  final List<DailyConsumptionData> data;
  const DailyConsumptionChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: "Consumo Diário"),
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        LineSeries<DailyConsumptionData, int>(
            dataSource: data,
            xValueMapper: (DailyConsumptionData data, _) => data.hour,
            yValueMapper: (DailyConsumptionData data, _) => data.consumption),
      ],
    );
  }
}
