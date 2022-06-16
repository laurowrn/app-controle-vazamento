import 'package:app/app/charts/consumption_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ConsumptionChart extends StatelessWidget {
  final List<ConsumptionData> data;
  const ConsumptionChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: "Consumo Diário"),
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        LineSeries<ConsumptionData, int>(
          dataSource: data,
          xValueMapper: (ConsumptionData data, _) => data.time,
          yValueMapper: (ConsumptionData data, _) => data.consumption,
        ),
      ],
    );
  }
}
