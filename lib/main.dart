import 'dart:math' as math show sqrt;

import 'package:flutter/material.dart';
import 'package:untitled/styles.dart';

typedef Func = void Function();

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String firstNumber = '';
  String operationSign = '';
  String displayNumber = '';
  num result = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.cyanAccent.shade700,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                display,
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 530,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 5,
                          mainAxisExtent: 100),
                      children: [
                        customButton('<-'),
                        customButton('-/+'),
                        customButton('%'),
                        customButton('√'),
                        customButton('1'),
                        customButton('2'),
                        customButton('3'),
                        customButton('/'),
                        customButton('4'),
                        customButton('5'),
                        customButton('6'),
                        customButton('*'),
                        customButton('7'),
                        customButton('8'),
                        customButton('9'),
                        customButton('-'),
                        customButton('C'),
                        customButton('0'),
                        customButton('.'),
                        customButton('+'),
                      ],
                    ),
                  ),
                ),
                customButton(
                  '=',
                  width: 400,
                  someFunc: () {
                    num num1 = num.parse(firstNumber);
                    num num2 = num.parse(displayNumber);
                    doOperation(num1: num1, num2: num2);
                    setState(() {
                      displayNumber = result.toString();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Doing Operation of Calc
  void doOperation({num num1 = 1, num num2 = 1}) {
    switch (operationSign) {
      case '+':
        result = num1 + num2;
      case '-':
        result = num1 - num2;
      case '*':
        result = num1 * num2;
      case '/':
        result = num1 / num2;
      case '%':
        result = num1 % num2;
      case '√':
        result = math.sqrt(num1);
    }
  }

  Widget customButton(String inputValue,
      {double height = 80, double width = 100, Func? someFunc}) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: (someFunc == null)
            ? () {
                setState(() {
                  if (displayNumber.isEmpty ||
                      displayNumber == 'Infinity' ||
                      displayNumber == 'NaN') {
                    displayNumber = inputValue;
                  } else {
                    if (displayNumber == '0' ||
                        displayNumber.isEmpty && inputValue == '.') {
                      displayNumber += '0$inputValue';
                    } else if (displayNumber != '0') {
                      displayNumber += inputValue;
                    } else {
                      displayNumber == '0';
                      print('lAST----------------');
                    }
                  }

                  switch (inputValue) {
                    case '+' || '*' || '/' || '-' || '%':
                      {
                        firstNumber = displayNumber.replaceRange(
                            displayNumber.length - 1, displayNumber.length, '');
                        displayNumber = '';
                        operationSign = inputValue;
                      }
                    case 'C':
                      firstNumber = '';
                      displayNumber = '';
                    case '<-':
                      removeLastDigitValue();
                    case '-/+':
                      makeValuePositiveOrNegative();
                    case '√':
                      firstNumber =
                          displayNumber.replaceFirst(RegExp(r'√'), '');
                      operationSign = inputValue;
                      doOperation(num1: num.parse(firstNumber));
                      displayNumber = result.toString();
                  }
                });
              }
            : someFunc,
        style: customButtonStyle,
        child: Text(inputValue),
      ),
    );
  }

  void removeLastDigitValue() {
    if (displayNumber.isNotEmpty) {
      if (displayNumber == '<-') {
        displayNumber = '';
      } else {
        displayNumber = displayNumber.replaceRange(
            displayNumber.length - 3, displayNumber.length, '');
      }
    }
  }

// How to make a value positive or negative
  void makeValuePositiveOrNegative() {
    final List<String> displayList = displayNumber.split('');
    if (displayList.first != '-') {
      displayList.removeWhere(
          (element) => element == '+' || element == '/' || element == '-');
    } else {
      displayList.removeWhere((element) => element == '+' || element == '/');
      displayList.removeLast();
    }
    displayNumber = displayList.join();
    num disNum = num.parse(displayNumber);
    if (disNum.isNegative) {
      disNum *= -1;
      displayNumber = disNum.toString();
    } else {
      disNum *= -1;
      displayNumber = disNum.toString();
    }
  }

  Widget get display {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          border: Border.all(
            color: Colors.purple,
            width: 5,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        width: 400,
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 150,
          child: Text(
            (displayNumber.isEmpty && firstNumber.isEmpty)
                ? '0'
                : displayNumber,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 55,
            ),
          ),
        ));
  }
}
// کامنت بگذارید عزیزان
// بیایید موارد زیر باهم به پایان برسانیم
// سورس کد داخل گیت هاب موجود هست
//todo:#1 Digits must not get more than one period(dot)
//todo:#2 avoid crashing when changing the operation
//todo:#3 remove decimal while dividing values
//todo:#3 you may want to limit display to show at least 12 to 14 digits
//todo:#4 if you don't contribute I have to do it by my own
