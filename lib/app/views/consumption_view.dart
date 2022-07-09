import 'dart:math';
import 'package:app/app/charts/consumption_chart.dart';
import 'package:app/app/charts/consumption_data.dart';
import 'package:app/app/components/layout.dart';
import 'package:app/app/models/SensorDataModel.dart';
import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ConsumptionView extends StatefulWidget {
  ConsumptionView({Key? key}) : super(key: key);

  @override
  State<ConsumptionView> createState() => _ConsumptionViewState();
}

class _ConsumptionViewState extends State<ConsumptionView> {
  ServerDataModel data = ServerDataModel();
  final List<ConsumptionData> data1 = getData();
  final List<ConsumptionData> data2 = getData();
  String dropdownValue = "Última hora";
  @override
  Widget build(BuildContext context) {
    return Layout(
      refresh: () async {
        var x = await data.getValveState("valve2");
        print(x);
      },
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 60,
              width: 150,
              child: DropdownButton<String>(
                isExpanded: true,
                iconSize: 50,
                value: dropdownValue,
                items: ["Última hora", "Últimas 24h", "Últimos 7 dias"].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
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
            FutureBuilder(
              future: data.getSensorData("sensor1", "volume"),
              builder: (context, snapshot) {
                return Container();
              },
            ),
            ChartCard(data: data2),
          ],
        ),
      ),
      title: "Consumo",
    );
  }
}

class ChartCard extends StatelessWidget {
  final List<ConsumptionData> data;
  const ChartCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.32,
      child: Card(
        child: ConsumptionChart(data: data),
      ),
    );
  }
}

List<ConsumptionData> getData() {
  List<ConsumptionData> data = [];
  for (int i = -100; i < 100; i++) {
    data.add(
      ConsumptionData(
        time: i,
        consumption: pow(i, 3).toInt(),
      ),
    );
  }
  return data;
}
