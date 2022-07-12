import 'package:app/app/models/ServerDataModel.dart';

class SettingsController {
  ServerDataModel server = ServerDataModel();

  Future<Map<String, double>> getSettings() async {
    var snapshot = await server.getSettings();
    Map<String, double> map = {};
    int baseTariff = snapshot["baseTariff"];
    int consumptionLimit = snapshot["consumptionLimit"];
    int baseConsumption = snapshot["baseConsumption"];
    int variableTariff = snapshot["variableTariff"];
    map["baseTariff"] = baseTariff.toDouble();
    map["consumptionLimit"] = consumptionLimit.toDouble();
    map["baseConsumption"] = baseConsumption.toDouble();
    map["variableTariff"] = variableTariff.toDouble();
    return map;
  }

  setSettings({
    required double consumptionLimit,
    required double baseConsumption,
    required double baseTariff,
    required double variableTariff,
  }) async {
    Map<String, double> map = {};
    map["consumptionLimit"] = consumptionLimit;
    map["baseConsumption"] = baseConsumption;
    map["baseTariff"] = baseTariff;
    map["variableTariff"] = variableTariff;
    await server.setSettings(map);
  }
}
