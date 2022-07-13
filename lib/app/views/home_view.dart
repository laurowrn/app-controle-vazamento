import 'package:app/app/components/layout.dart';
import 'package:app/app/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
      },
      actionIcon: Icons.golf_course,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: [
          Container(
            child: Card(
              child: Column(
                children: [
                  Column(
                    children: const [
                      Text(
                        "Estatísticas de consumo",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: const [
                        Divider(),
                        Text(
                          "Consumo do dia: 200 L",
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          "Consumo do mês: 3000 L",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
      title: "Home",
    );
  }
}
