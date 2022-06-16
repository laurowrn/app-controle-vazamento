import 'package:app/app/components/layout.dart';
import 'package:app/app/views/home_view.dart';
import 'package:flutter/material.dart';

class ControlView extends StatefulWidget {
  ControlView({Key? key}) : super(key: key);

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  bool switchState1 = false;
  bool switchState2 = false;
  @override
  Widget build(BuildContext context) {
    return Layout(
      body: ListView(
        children: [
          ControlTile(
            title: "Geral",
            value: switchState1,
            onChanged: (value) {
              setState(() {
                switchState1 = !switchState1;
              });
            },
          ),
          ControlTile(
            title: "Torneira",
            value: switchState2,
            onChanged: (value) {
              setState(() {
                switchState2 = !switchState2;
              });
            },
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
