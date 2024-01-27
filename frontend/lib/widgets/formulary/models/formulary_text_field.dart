import 'package:flutter/material.dart';

import 'formulary_field.dart';

class FormularyTextField extends FormularyField {
  final TextEditingController controller;

  FormularyTextField(super.validator, {required super.icon, required super.title, required this.controller});
}