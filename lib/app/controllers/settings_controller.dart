import 'package:app/app/models/ServerDataModel.dart';

class SettingsController {
  ServerDataModel server = ServerDataModel();

  Map<String, double> settings = {
    "consumptionLimit": 0,
    "baseConsumption": 0,
    "baseTariff": 0,
    "variableTariff": 0,
  };

  updateLocalSettings() async {
    var newSettings = await server.getSettings();
  }

  setSettings({
    required double consumptionLimit,
    required double baseConsumption,
    required double baseTariff,
    required double variableTariff,
  }) async {
    settings = {
      "consumptionLimit": consumptionLimit,
      "baseConsumption": baseConsumption,
      "baseTariff": baseTariff,
      "variableTariff": variableTariff,
    };
    server.setSettings(settings);
  }
}
