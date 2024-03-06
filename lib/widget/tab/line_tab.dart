import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LineTab extends StatefulWidget {
  const LineTab({super.key, required this.data, required this.onIndexChanged});

  final List<String> data;
  final Function(int) onIndexChanged;

  @override
  State<LineTab> createState() => _LineTabState();
}

class _LineTabState extends State<LineTab> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: widget.data
            .asMap()
            .entries
            .map((e) => Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        activeIndex = e.key;
                      });

                      widget.onIndexChanged(e.key);
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: e.key == activeIndex
                                ? Theme.of(context).primaryColor
                                : Colors.black12,
                          ),
                        ),
                      ),
                      child: Text(
                        e.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: e.key == activeIndex
                              ? Theme.of(context).primaryColor
                              : Colors.black26,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
