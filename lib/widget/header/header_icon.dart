import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({super.key, required this.icon, this.color, this.useBack});

  final IconData icon;
  final Color? color;
  final bool? useBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          if (useBack != null) {
            Navigator.pop(context);
          }
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Icon(
            icon,
            color: color ?? const Color.fromARGB(137, 64, 64, 64),
            size: 22,
          ),
        ),
      ),
    );
  }
}
