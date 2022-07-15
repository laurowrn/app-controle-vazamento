import 'package:app/app/components/layout.dart';
import 'package:app/app/controllers/home_controller.dart';
import 'package:app/app/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController = HomeController();
  late Future<double> lastWeekConsumption;
  late Future<double> lastMonthConsumption;
  late Future<double> totalCost;

  update() async {
    lastWeekConsumption = homeController.getLastWeekConsumption();
    lastMonthConsumption = homeController.getLastMonthConsumption();
    totalCost = homeController.getTotalCost();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      update();
    });
  }

  bool valor = false;
  @override
  Widget build(BuildContext context) {
    return Layout(
      action: () async {
        valor = !valor;
        if (valor) {
          Provider.of<NotificationService>(context, listen: false).showNotification(CustomNotification(
            id: 1,
            title: 'Teste',
            body: 'Acesse o app',
            payload: '/settings',
          ));
        }
        setState(() {
          update();
        });
      },
      actionIcon: Icons.refresh,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            FutureBuilder<double>(
              future: lastWeekConsumption,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InfoCard(
                    title: "Consumo na semana",
                    value: "${snapshot.data.toString().replaceAll(".", ",")} m³",
                  );
                }
                return Container();
              },
            ),
            FutureBuilder<double>(
              future: lastMonthConsumption,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return InfoCard(
                    title: "Consumo no mês",
                    value: "${snapshot.data.toString().replaceAll(".", ",")} m³",
                  );
                }
                return Container();
              }),
            ),
            FutureBuilder<double>(
              future: totalCost,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return InfoCard(
                    title: "Custo total",
                    value: "R\$ ${snapshot.data.toString().replaceAll(".", ",")}",
                  );
                }
                return Container();
              }),
            ),
          ],
        ),
      ),
      title: "Home",
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  const InfoCard({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
              const Divider(),
              Text(
                value,
                style: const TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
