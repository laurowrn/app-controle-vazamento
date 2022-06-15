import 'package:app/app/components/layout.dart';
import 'package:app/app/views/home_view.dart';
import 'package:flutter/material.dart';

class ControlView extends StatefulWidget {
  ControlView({Key? key}) : super(key: key);

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Controle",
    );
  }
}
