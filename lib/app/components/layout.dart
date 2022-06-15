import 'package:app/app/routes.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  final String title;
  Layout({Key? key, required this.title}) : super(key: key);

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
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
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
