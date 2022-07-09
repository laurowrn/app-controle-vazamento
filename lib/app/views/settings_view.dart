import 'package:app/app/components/layout.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();
  String dailyConsumptionLimit = "0";
  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Configurações",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  maxLength: 5,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.water_damage),
                    labelText: "Limite do alerta de consumo diário",
                  ),
                  controller: textEditingController1,
                  onChanged: (newText) {
                    dailyConsumptionLimit = textEditingController1.text;
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  maxLength: 5,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.inventory),
                    labelText: "Consumo base",
                  ),
                  controller: textEditingController2,
                  onChanged: (newText) {
                    dailyConsumptionLimit = textEditingController2.text;
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  maxLength: 5,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.attach_money),
                    labelText: "Tarifa base",
                  ),
                  controller: textEditingController3,
                  onChanged: (newText) {
                    dailyConsumptionLimit = textEditingController3.text;
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  maxLength: 5,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.attach_money),
                    labelText: "Tarifa variável",
                  ),
                  controller: textEditingController4,
                  onChanged: (newText) {
                    dailyConsumptionLimit = textEditingController4.text;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
