import 'package:app/app/models/ServerDataModel.dart';

class ControlController {
  ServerDataModel server = ServerDataModel();

  Future<bool> getValve1State() async {
    return await server.getValveState("valve1");
  }

  Future<bool> getValve2State() async {
    return await server.getValveState("valve2");
  }

  changeValve1State(bool currentState) async {
    return await server.setValveState("valve1", currentState);
  }

  changeValve2State(bool currentState) async {
    return await server.setValveState("valve2", currentState);
  }
}
