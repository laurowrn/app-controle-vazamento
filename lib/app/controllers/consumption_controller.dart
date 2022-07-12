import 'package:app/app/charts/consumption_data.dart';
import 'package:app/app/models/ServerDataModel.dart';
import 'package:intl/intl.dart';

class ConsumptionController {
  ServerDataModel server = ServerDataModel();

  Future<List<ConsumptionData>> getLastHourVolumeConsumption() async {
    var response = await server.getSensorData("sensor2", "volume");
    var length = response.length;
    var data;
    if (length <= 720) {
      data = response;
    } else {
      data = response.sublist(length - 720, length);
    }
    List<ConsumptionData> list = [];
    response.forEach((element) {
      var milliseconds = DateTime.now().millisecondsSinceEpoch - 5000 * length;
      var date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
      String formattedTime = DateFormat.Hm().format(date);
      var hour = formattedTime.replaceAll(":", "");
      var newData = ConsumptionData(time: int.parse(hour), consumption: element);
      length--;
      list.add(newData);
    });
    return list;
  }

  Future<List<ConsumptionData>> getLast24HVolumeConsumption() async {
    var response = await server.getSensorData("sensor2", "volume");
    var length = response.length;
    var data;
    if (length <= 17280) {
      data = response;
    } else {
      data = response.sublist(length - 720, length);
    }

    List<ConsumptionData> list = [];
    response.forEach((element) {
      var milliseconds = DateTime.now().millisecondsSinceEpoch - 5000 * length;
      var date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
      String formattedTime = DateFormat.Hm().format(date);
      var hour = formattedTime.replaceAll(":", "");
      var newData = ConsumptionData(time: int.parse(hour), consumption: element);
      length--;
      list.add(newData);
    });
    return list;
  }
}
