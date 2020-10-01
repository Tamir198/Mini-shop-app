import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String routName, title;
  final Icon icon;

  DrawerItem({@required this.routName, @required this.title, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: (){
        Navigator.of(context).pushReplacementNamed(routName);
      },
    );
  }
}
