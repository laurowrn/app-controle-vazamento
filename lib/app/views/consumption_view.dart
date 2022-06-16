import 'dart:math';
import 'package:app/app/charts/daily_consumption_chart.dart';
import 'package:app/app/charts/daily_consumption_data.dart';
import 'package:app/app/components/layout.dart';
import 'package:flutter/material.dart';

class ConsumptionView extends StatefulWidget {
  ConsumptionView({Key? key}) : super(key: key);

  @override
  State<ConsumptionView> createState() => _ConsumptionViewState();
}

class _ConsumptionViewState extends State<ConsumptionView> {
  final List<DailyConsumptionData> data1 = getData();
  final List<DailyConsumptionData> data2 = getData();
  String dropdownValue = "Última hora";
  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 70,
              width: 400,
              child: DropdownButton<String>(
                isExpanded: true,
                iconSize: 50,
                value: dropdownValue,
                items: ["Última hora", "Últimas 24h", "Últimos 7 dias"].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 25),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ChartCard(data: data1),
            ChartCard(data: data2),
          ],
        ),
      ),
      title: "Consumo",
    );
  }
}

class ChartCard extends StatelessWidget {
  final List<DailyConsumptionData> data;
  const ChartCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 400,
      child: Card(
        child: DailyConsumptionChart(data: data),
      ),
    );
  }
}

List<DailyConsumptionData> getData() {
  List<DailyConsumptionData> data = [];
  for (int i = -100; i < 100; i++) {
    data.add(
      DailyConsumptionData(
        hour: i,
        consumption: pow(i, 3).toInt(),
      ),
    );
  }
  return data;
}
