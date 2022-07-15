import 'package:app/app/charts/consumption_chart.dart';
import 'package:app/app/charts/consumption_data.dart';
import 'package:app/app/components/layout.dart';
import 'package:app/app/controllers/consumption_controller.dart';
import 'package:flutter/material.dart';

class ConsumptionView extends StatefulWidget {
  ConsumptionView({Key? key}) : super(key: key);

  @override
  State<ConsumptionView> createState() => _ConsumptionViewState();
}

class _ConsumptionViewState extends State<ConsumptionView> {
  ConsumptionController consumptionController = ConsumptionController();
  late Future<List<ConsumptionData>> last10Minutes;
  late Future<List<ConsumptionData>> lastHour;
  late Future<List<ConsumptionData>> last24Hours;
  String dropdownValue = "Últimos 10 minutos";

  update() async {
    last10Minutes = consumptionController.getLast10MinutesFlowRate();
    lastHour = consumptionController.getLastHourFlowRate();
    last24Hours = consumptionController.getLast24HoursFlowRate();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      update();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      actionIcon: Icons.refresh,
      action: () async {
        setState(() {
          update();
        });
      },
      body: Center(
        child: Column(
          children: [
            Container(
              height: 60,
              width: 200,
              child: DropdownButton<String>(
                isExpanded: true,
                iconSize: 50,
                value: dropdownValue,
                items:
                    ["Últimos 10 minutos", "Última hora", "Últimas 24h"].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 15),
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
            if (dropdownValue == "Última hora") ...[
              FutureBuilder<List<ConsumptionData>>(
                future: lastHour,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ChartCard(data: snapshot.data!, chartTitle: "Consumo na última hora");
                  }
                  return Container();
                },
              ),
            ] else if (dropdownValue == "Últimas 24h") ...[
              FutureBuilder<List<ConsumptionData>>(
                future: last24Hours,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ChartCard(data: snapshot.data!, chartTitle: "Consumo nas últimas 24H");
                  }
                  return Container();
                },
              )
            ] else if (dropdownValue == "Últimos 10 minutos") ...[
              FutureBuilder<List<ConsumptionData>>(
                future: last10Minutes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ChartCard(data: snapshot.data!, chartTitle: "Consumo nos últimos 10 minutos");
                  }
                  return Container();
                },
              )
            ]
          ],
        ),
      ),
      title: "Consumo",
    );
  }
}

class ChartCard extends StatelessWidget {
  final List<ConsumptionData> data;
  final String chartTitle;
  const ChartCard({Key? key, required this.data, required this.chartTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.50,
      child: Card(
        child: ConsumptionChart(
          data: data,
          chartTitle: chartTitle,
        ),
      ),
    );
  }
}
