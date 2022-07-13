import 'package:app/app/models/ServerDataModel.dart';

class SettingsController {
  ServerDataModel server = ServerDataModel();

  Future<Map<String, double>> getSettings() async {
    var snapshot = await server.getSettings();
    Map<String, double> map = {};
    double baseTariff = snapshot["baseTariff"].toDouble();
    double consumptionLimit = snapshot["consumptionLimit"].toDouble();
    double baseConsumption = snapshot["baseConsumption"].toDouble();
    double variableTariff = snapshot["variableTariff"].toDouble();
    map["baseTariff"] = baseTariff;
    map["consumptionLimit"] = consumptionLimit;
    map["baseConsumption"] = baseConsumption;
    map["variableTariff"] = variableTariff;
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
