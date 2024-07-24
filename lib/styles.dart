import 'package:flutter/material.dart';

final customButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.black38,
  foregroundColor: Colors.white,
  textStyle: const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  ),
  padding: const EdgeInsets.all(0),
  alignment: Alignment.center,
  shape: ContinuousRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    side: BorderSide(
      strokeAlign: BorderSide.strokeAlignOutside,
      color: Colors.deepOrangeAccent.shade400,
      width: 2,
    ),
  ),
);
