import 'package:app/app/components/layout.dart';
import 'package:flutter/material.dart';

class ConsumptionView extends StatefulWidget {
  ConsumptionView({Key? key}) : super(key: key);

  @override
  State<ConsumptionView> createState() => _ConsumptionViewState();
}

class _ConsumptionViewState extends State<ConsumptionView> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Consumo",
    );
  }
}
