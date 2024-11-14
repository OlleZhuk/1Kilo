/// Модель поля ввода данных
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValueInput extends StatelessWidget {
  const ValueInput({
    super.key,
    required this.controller,
    required this.clear,
    required this.inputListener,
  });

  final TextEditingController controller;
  final Function() clear;
  final Function(String) inputListener;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        keyboardType: TextInputType.number,

        /// Чтобы никаких точек и запятых:
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        // -------------------------------
        style: const TextStyle(
          fontSize: 18,
          color: Colors.amberAccent,
        ),
        decoration: InputDecoration(
          isDense: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  onPressed: clear,
                  icon: const Icon(Icons.clear, size: 20),
                )
              : null,
        ),
        onChanged: inputListener,
      );
}
