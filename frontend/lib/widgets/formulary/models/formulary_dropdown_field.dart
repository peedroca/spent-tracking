import 'package:get/get.dart';

import 'formulary_field.dart';

class FormularyDropdownField extends FormularyField {
  final String? initialValue;
  final RxList<dynamic> items;
  final String field;
  final void Function(String? value) onChanged;

  FormularyDropdownField({required super.icon, required super.title, this.initialValue, required this.items, required this.field, required this.onChanged}) : super((_) => "");
}