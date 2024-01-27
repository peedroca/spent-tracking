import 'package:flutter/material.dart';

class FormularyField {
  final IconData icon;
  final String title;
  final String? Function(dynamic value) validator;

  FormularyField(this.validator, {required this.icon, required this.title});
}