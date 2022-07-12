import 'package:app/app/components/layout.dart';
import 'package:app/app/controllers/control_controller.dart';
import 'package:flutter/material.dart';

class ControlView extends StatefulWidget {
  ControlView({Key? key}) : super(key: key);

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  ControlController controlController = ControlController();
  late Future<bool> switchState1;
  late Future<bool> switchState2;

  void getStates() async {
    setState(() {
      switchState1 = controlController.getValve1State();
      switchState2 = controlController.getValve2State();
    });
  }

  @override
  void initState() {
    super.initState();
    getStates();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: ListView(
        children: [
          FutureBuilder<bool>(
            future: switchState1,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ControlTile(
                  title: "Geral",
                  value: snapshot.data!,
                  onChanged: (value) async {
                    var valveState = await switchState1;
                    await controlController.changeValve1State(valveState);
                    setState(() {
                      getStates();
                    });
                  },
                );
              } else {
                return Container();
              }
            }),
          ),
          FutureBuilder<bool>(
            future: switchState2,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ControlTile(
                  title: "Torneira",
                  value: snapshot.data!,
                  onChanged: (value) async {
                    var valveState = await switchState2;
                    await controlController.changeValve2State(valveState);
                    setState(() {
                      getStates();
                    });
                  },
                );
              } else {
                return Container();
              }
            }),
          ),
        ],
      ),
      title: "Controle",
    );
  }
}

class ControlTile extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool)? onChanged;
  const ControlTile({Key? key, required this.title, required this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Card(
        child: ListTile(
          trailing: Switch(
            value: value,
            onChanged: onChanged,
          ),
          title: Text(title),
        ),
      ),
    );
  }
}
