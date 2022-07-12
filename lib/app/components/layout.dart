import 'package:app/app/routes.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  final String title;
  final Widget body;
  final void Function()? action;
  final IconData? actionIcon;
  Layout({Key? key, required this.title, required this.body, this.action, this.actionIcon}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        actions: [
          widget.action != null
              ? IconButton(
                  onPressed: widget.action,
                  icon: Icon(widget.actionIcon),
                )
              : Container()
        ],
      ),
      body: widget.body,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                child: Text("Menu"),
              ),
            ),
            MenuTile(
              leadingIcon: Icons.home,
              title: "Home",
              namedRoute: "/home",
            ),
            MenuTile(
              leadingIcon: Icons.toggle_on,
              title: "Controle",
              namedRoute: "/control",
            ),
            MenuTile(
              leadingIcon: Icons.bar_chart_rounded,
              title: "Consumo",
              namedRoute: "/consumption",
            ),
            MenuTile(
              leadingIcon: Icons.settings,
              title: "Configurações",
              namedRoute: "/settings",
            ),
          ],
        ),
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String namedRoute;
  const MenuTile({Key? key, required this.leadingIcon, required this.title, required this.namedRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(leadingIcon),
          title: Text(title),
          onTap: () {
            Navigator.of(Routes.navigatorKey!.currentContext!).pushReplacementNamed(namedRoute);
          },
        ),
        Container(
          color: Colors.grey[200],
          height: 1,
        )
      ],
    );
  }
}
