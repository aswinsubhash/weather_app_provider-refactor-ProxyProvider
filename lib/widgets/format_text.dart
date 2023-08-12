import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

Widget formatText(String description) {
  final formattedString = description.titleCase;
  return Text(
    formattedString,
    style: const TextStyle(fontSize: 24.0),
    textAlign: TextAlign.center,
  );
}
