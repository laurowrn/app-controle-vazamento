import 'package:app/app/models/ServerDataModel.dart';

class HomeController {
  ServerDataModel server = ServerDataModel();

  Future<double> getLastWeekConsumption() async {
    double consumption = 0;
    List response = await server.getSensorData("sensor2", "volume");
    var length = response.length;
    var data;
    if (length >= 120960) {
      data = response.sublist(length - 120960, length);
    } else {
      data = response;
    }
    data.forEach((element) async {
      consumption += element["value"];
    });
    double newConsumption = consumption / 1000;
    newConsumption = double.parse(newConsumption.toStringAsFixed(2));
    return newConsumption;
  }

  Future<double> getLastMonthConsumption() async {
    double consumption = 0;
    List response = await server.getSensorData("sensor2", "volume");
    var length = response.length;
    var data;
    if (length >= 483840) {
      data = response.sublist(length - 483840, length);
    } else {
      data = response;
    }
    data.forEach((element) async {
      consumption += element["value"];
    });
    double newConsumption = consumption / 1000;
    newConsumption = double.parse(newConsumption.toStringAsFixed(2));
    return newConsumption;
  }

  Future<double> getTotalCost() async {
    double consumption = await getLastMonthConsumption();
    var snapshot = await server.getSettings();
    double baseTariff = snapshot["baseTariff"].toDouble();
    double baseConsumption = snapshot["baseConsumption"].toDouble();
    double variableTariff = snapshot["variableTariff"].toDouble();

    if (consumption <= baseConsumption) {
      return double.parse(baseTariff.toStringAsFixed(2));
    } else if (consumption > baseConsumption) {
      var difference = consumption - baseConsumption;
      return double.parse((baseTariff + (difference * variableTariff)).toStringAsFixed(2));
    }
    return 0.0;
  }
}
