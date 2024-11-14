/// Модель кнопки
library;

import 'package:flutter/material.dart';

class GetResultButton extends StatelessWidget {
  const GetResultButton({
    super.key,
    required this.title,
    required this.pathName,
    required this.getResult,
  });

  final String title, pathName;
  final Function() getResult;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cSheme = Theme.of(context).colorScheme;
    final BorderSide side = BorderSide(
      color: Colors.orangeAccent.withOpacity(.5),
      width: 1,
    );

    return OutlinedButton.icon(
      onPressed: getResult,
      label: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      icon: Image.asset(
        pathName,
        scale: 3,
        color: Colors.white70,
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: cSheme.inverseSurface,
        side: side,
      ),
    );
  }
}
