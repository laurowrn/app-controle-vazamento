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
    Map<String, double> set = await settings;
    textEditingController1.text = set["consumptionLimit"].toString();
    textEditingController2.text = set["baseConsumption"].toString();
    textEditingController3.text = set["baseTariff"].toString();
    textEditingController4.text = set["variableTariff"].toString();
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
        await settingsController.setSettings(
          consumptionLimit: double.parse(textEditingController1.text),
          baseConsumption: double.parse(textEditingController2.text),
          baseTariff: double.parse(textEditingController3.text),
          variableTariff: double.parse(textEditingController4.text),
        );
        setState(() {
          update();
        });
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
                      labelText: "Limite de consumo",
                    ),
                    SettingsTextField(
                      textEditingController: textEditingController2,
                      labelText: "Consumo base",
                    ),
                    SettingsTextField(
                      textEditingController: textEditingController3,
                      labelText: "Tarifa base",
                    ),
                    SettingsTextField(
                      textEditingController: textEditingController4,
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
  final String labelText;
  const SettingsTextField({Key? key, required this.textEditingController, required this.labelText}) : super(key: key);

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
      ],
    );
    ;
  }
}
