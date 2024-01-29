import 'package:flutter/material.dart';

import 'formulary_field.dart';

class FormularySmallHelp extends FormularyField {
  final String helpText;

  FormularySmallHelp({required this.helpText}) : super((_) => "", icon: Icons.abc, title: '');
}