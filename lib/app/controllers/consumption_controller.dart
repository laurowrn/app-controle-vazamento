import 'package:app/app/charts/consumption_data.dart';
import 'package:app/app/models/ServerDataModel.dart';
import 'package:intl/intl.dart';

class ConsumptionController {
  ServerDataModel server = ServerDataModel();

  Future<List<ConsumptionData>> getLastHourVolumeConsumption() async {
    List response = await server.getSensorData("sensor2", "volume");
    var length = response.length;
    var data;
    if (length >= 720) {
      data = response.sublist(length - 720, length);
    } else {
      data = response;
    }
    List<ConsumptionData> list = [];
    data.forEach((element) {
      list.add(ConsumptionData(
          time: element["timestamp"], consumption: element["value"]));
    });
    return list;
  }

  Future<List<ConsumptionData>> getLast24HVolumeConsumption() async {
    List response = await server.getSensorData("sensor2", "volume");
    var length = response.length;
    var data;
    if (length >= 720) {
      data = response.sublist(length - 17280, length);
    } else {
      data = response;
    }
    List<ConsumptionData> list = [];
    data.forEach((element) {
      list.add(ConsumptionData(
          time: element["timestamp"], consumption: element["value"]));
    });
    return list;
  }
}
