import 'package:app/app/components/layout.dart';
import 'package:app/app/controllers/settings_controller.dart';
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
  SettingsController settingsController = SettingsController();
  late Future<Map<String, double>> settings;
  update() async {
    settings = settingsController.getSettings();
  }

  @override
  void initState() {
    super.initState();
    update();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      actionIcon: Icons.save,
      action: () async {
        setState(() {
          update();
        });
        await settingsController.setSettings(
          consumptionLimit: double.parse(textEditingController1.text),
          baseConsumption: double.parse(textEditingController2.text),
          baseTariff: double.parse(textEditingController3.text),
          variableTariff: double.parse(textEditingController4.text),
        );
      },
      title: "Configurações",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<Map<String, double>>(
            future: settings,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    SettingsTextField(
                      textEditingController: textEditingController1,
                      text: snapshot.requireData["consumptionLimit"].toString(),
                      labelText: "Limite de consumo",
                    ),
                    SettingsTextField(
                      textEditingController: textEditingController2,
                      text: snapshot.requireData["baseConsumption"].toString(),
                      labelText: "Consumo base",
                    ),
                    SettingsTextField(
                      textEditingController: textEditingController3,
                      text: snapshot.requireData["baseTariff"].toString(),
                      labelText: "Tarifa base",
                    ),
                    SettingsTextField(
                      textEditingController: textEditingController4,
                      text: snapshot.requireData["variableTariff"].toString(),
                      labelText: "Tarifa variavel",
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class SettingsTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String text;
  final String labelText;
  const SettingsTextField(
      {Key? key,
      required this.textEditingController,
      required this.text,
      required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            maxLength: 5,
            decoration: InputDecoration(
              icon: const Icon(Icons.water_damage),
              labelText: labelText,
            ),
            controller: textEditingController,
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        Text(text),
      ],
    );
    ;
  }
}
