import 'package:flutter/material.dart';

class ActionOption {
  final String title;
  final IconData icon;
  final void Function(int index, dynamic data) onTap;
  final MaterialColor? backgroundColor;
  final MaterialColor? textColor;

  ActionOption({required this.title, required this.icon, required this.onTap, this.backgroundColor, this.textColor});
}