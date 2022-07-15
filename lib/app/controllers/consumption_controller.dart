import 'package:app/app/charts/consumption_data.dart';
import 'package:app/app/models/ServerDataModel.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class ConsumptionController {
  ServerDataModel server = ServerDataModel();

  Future<List<ConsumptionData>> getLast10MinutesFlowRate() async {
    List response = await server.getSensorData("sensor2", "flowRate");
    var length = response.length;
    var data;
    if (length >= 120) {
      data = response.sublist(length - 120, length);
    } else {
      data = response;
    }
    List<ConsumptionData> list = [];
    data.forEach((element) async {
      var date = DateTime.fromMillisecondsSinceEpoch(element["timestamp"]);
      list.add(ConsumptionData(time: element["timestamp"], consumption: element["value"]));
    });
    return list;
  }

  Future<List<ConsumptionData>> getLastHourFlowRate() async {
    List response = await server.getSensorData("sensor2", "flowRate");
    var length = response.length;
    var data;
    if (length >= 720) {
      data = response.sublist(length - 720, length);
    } else {
      data = response;
    }
    List<ConsumptionData> list = [];
    data.forEach((element) async {
      var date = DateTime.fromMillisecondsSinceEpoch(element["timestamp"]);
      list.add(ConsumptionData(time: element["timestamp"], consumption: element["value"]));
    });
    return list;
  }

  Future<List<ConsumptionData>> getLast24HoursFlowRate() async {
    List response = await server.getSensorData("sensor2", "flowRate");
    var length = response.length;
    var data;
    if (length >= 17280) {
      data = response.sublist(length - 17280, length);
    } else {
      data = response;
    }
    List<ConsumptionData> list = [];
    data.forEach((element) {
      list.add(ConsumptionData(time: element["timestamp"], consumption: element["value"]));
    });
    return list;
  }
}
