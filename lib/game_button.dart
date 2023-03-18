import 'package:flutter/material.dart';

class GameButton {
  final id;
  String text;
  Color bg;
  bool enabled;

  GameButton(
      {this.bg = Colors.grey, this.id, this.text = '', this.enabled = true});
}
