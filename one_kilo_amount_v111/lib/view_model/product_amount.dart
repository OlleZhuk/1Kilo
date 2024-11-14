/// Поставщик стоимости продукта
library;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../models/get_result_button.dart';
import '../models/value_input_form.dart';

class ProductAmount extends StatefulWidget {
  const ProductAmount({super.key, required this.name});

  final String name;

  @override
  State<ProductAmount> createState() => _ProductAmountState();
}

class _ProductAmountState extends State<ProductAmount> {
  final weightInputController = TextEditingController();
  final amountInputController = TextEditingController();
  String? preResult, result;
  int? enteredWeight, enteredAmount;

  getAmount(int key) {
    if (enteredWeight == null ||
        enteredWeight == 0 ||
        enteredAmount == null ||
        enteredAmount == 0) {
      return null;
    } else {
      final preResult =
          ((key == 1 ? 1000 : 10) * enteredAmount! / enteredWeight!)
              .ceil()
              .toString();

      setState(() {
        result = preResult;

        /// Скрытие клавиатуры
        FocusScope.of(context).unfocus();
      });
    }
  }

  Widget clearButton() => IconButton(
      onPressed: () {
        weightInputController.clear();
        amountInputController.clear();
        setState(() => result = null);
      },
      icon: Image.asset(
        'assets/icons/refresh.png',
        scale: 3,
        color: Colors.white70,
      ));

  @override
  void dispose() {
    weightInputController.dispose();
    amountInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cSheme = Theme.of(context).colorScheme;
    final double wSize = MediaQuery.sizeOf(context).width;
    final double rightSpace = wSize * .2;
    final BorderSide side = BorderSide(color: cSheme.onSecondary, width: 1);
    const BorderRadiusGeometry borderRadius =
        BorderRadius.all(Radius.circular(16.0));
    const EdgeInsetsGeometry all10 = EdgeInsets.all(10);
    const double textFieldSize = 14;

    return Padding(
        padding: all10,

        /// Основной столбец
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Строка с названием Продукта и кнопкой очистки
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.name,
                    style: TextStyle(
                      fontSize: 24,
                      color: cSheme.outlineVariant,
                    )),

                /// Кнопка очистки полей ввода
                clearButton(),
              ],
            ),

            /// Стек прямоугольного и круглого контейнеров
            Stack(
              alignment: Alignment.centerRight,
              children: [
                /// Ряд с прямоугольным контейнером и заполнителем
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(100, 13, 21, 34),
                                  Color.fromARGB(150, 21, 34, 55),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: borderRadius,
                              border: Border(
                                top: side,
                                bottom: side,
                                left: side,
                              )),
                          //
                          child: Padding(
                              padding: all10,

                              /// Ряд с колонкой данных и заполнителем
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, bottom: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Стоимость, руб.',
                                                  style: TextStyle(
                                                    fontSize: textFieldSize,
                                                    color: Colors.orangeAccent,
                                                  )),
                                              const Gap(6),

                                              /// Поле ввода Стоимости
                                              ValueInput(
                                                controller:
                                                    amountInputController,
                                                clear: () {
                                                  amountInputController.clear();
                                                  setState(() =>
                                                      enteredAmount = null);
                                                },
                                                inputListener: (amount) =>
                                                    setState(() =>
                                                        enteredAmount =
                                                            int.tryParse(
                                                                amount)),
                                              ),
                                              const Gap(8),

                                              /// Поле ввода массы
                                              ValueInput(
                                                controller:
                                                    weightInputController,
                                                clear: () {
                                                  weightInputController.clear();
                                                  setState(() =>
                                                      enteredWeight = null);
                                                },
                                                inputListener: (weight) =>
                                                    setState(() =>
                                                        enteredWeight =
                                                            int.tryParse(
                                                                weight)),
                                              ),
                                              const Gap(6),
                                              const Text('Вес, кол-во',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: textFieldSize,
                                                    color: Colors.orangeAccent,
                                                  )),
                                              const Text(
                                                '(г, мл, шт.)',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ],
                                          ))),

                                  /// Заполнитель, нужный под круглым контейнером
                                  Container(width: wSize * .25),
                                ],
                              ))),
                    ),

                    /// Заполнитель справа от прямоугольного контейнера,
                    /// таков же будет радиус круга
                    Container(width: rightSpace),
                  ],
                ),

                /// Круглый бокс
                Positioned(
                    child: Container(
                        width: rightSpace * 2,
                        height: rightSpace * 2,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              cSheme.surfaceContainerLowest,
                              cSheme.scrim,
                            ],
                            center: Alignment.center,
                            radius: .6,
                            stops: const [0, 1],
                          ),
                          borderRadius: BorderRadius.circular(rightSpace),
                        ),
                        //
                        child: Padding(
                            padding: all10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  result ?? '0',
                                  style: const TextStyle(fontSize: 30),
                                ),
                                const Icon(Icons.currency_ruble, size: 28)
                              ],
                            ))))
              ],
            ),
            //
            const Gap(12),

            /// Контейнер с текстом и кнопками
            Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.transparent,
                      Color.fromARGB(150, 21, 34, 55),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: borderRadius,
                  border: Border.fromBorderSide(side),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: all10,
                      child: Text('Цена за 1 кг (1 литр) или 10 штук:'),
                    ),

                    /// Ряд кнопок
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GetResultButton(
                          getResult: () => getAmount(1),
                          title: '1 кг',
                          pathName: 'assets/icons/peace.png',
                        ),
                        GetResultButton(
                          getResult: () => getAmount(1),
                          title: '1 л',
                          pathName: 'assets/icons/bottle.png',
                        ),
                        GetResultButton(
                          getResult: () => getAmount(2),
                          title: '10 штук',
                          pathName: 'assets/icons/egg.png',
                        ),
                      ],
                    ),
                    const Gap(8),
                  ],
                ))
          ],
        ));
  }
}

    /// Column (основной столбец)
    ///   │
    ///   ├─ Row [Text, clearButton]
    ///   │
    ///   ├─ Stack
    ///   │    ├─ Row [Container, Container_placeholder]
    ///   │    │         │
    ///   │    │         └─ Row [Column, Container_placeholder]
    ///   │    │                   ├─ Text
    ///   │    │                   ├─ TextField
    ///   │    │                   ├─ TextField
    ///   │    │                   ├─ Text
    ///   │    │                   └─ Text
    ///   │    │
    ///   │    └─ Positioned_Container
    ///   │                    └─ Row [Amount_Text, Icon]
    ///   └─ Container
    ///        └─ Column
    ///             ├─ Text
    ///             └─ Row [Button, Button, Button]
