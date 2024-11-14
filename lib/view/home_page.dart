/// Домашняя
library;

import 'package:flutter/material.dart';

import '../view_model/product_amount.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cSheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
          backgroundColor: cSheme.scrim,
          body: const SingleChildScrollView(
              child: Column(
            children: [
              ProductAmount(name: 'Продукт 1'),
              ProductAmount(name: 'Продукт 2'),
            ],
          ))),
    );
  }
}
