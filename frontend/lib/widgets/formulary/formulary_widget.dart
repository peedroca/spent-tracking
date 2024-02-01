import 'package:flutter/material.dart';
import 'package:spenttracking/common/my_theme.dart';
import 'package:spenttracking/widgets/formulary/models/formulary_field.dart';

import '../../common/my_theme.input.dart';
import '../button/button_widget.dart';
import 'models/formulary_dropdown_field.dart';
import 'models/formulary_small_help.dart';
import 'models/formulary_text_field.dart';

class FormularyWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function() onClearForm;
  final void Function() onSaveForm;
  final List<FormularyField> fields;
  const FormularyWidget({super.key, required this.fields, required this.formKey, required this.onClearForm, required this.onSaveForm});

  @override
  Widget build(BuildContext context) {
    final fieldsList = <Widget>[];

    for (FormularyField field in fields) {
      switch (field.runtimeType) {
        case FormularySmallHelp:
          var typedField = field as FormularySmallHelp;
          fieldsList.add(SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,),
              child: Text(
                typedField.helpText,
                style: TextStyle(color: MyTheme.primaryDark),
              ),
            ),
          ));
          break;
        case FormularyTextField:
          var typedField = field as FormularyTextField;
          fieldsList.add(TextFormField(
            controller: typedField.controller,
            validator: typedField.validator,
            decoration: MyThemeInputs.textInput.copyWith(
              labelText: typedField.title,
              prefixIcon: Icon(typedField.icon),
            ),
          ));
          break;
        case FormularyDropdownField:
          var typedField = field as FormularyDropdownField;
          fieldsList.add(Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: MyTheme.primaryDark),
              borderRadius: MyTheme.borderRadius, 
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(typedField.icon, color: MyTheme.primaryDark,),
              ),
              iconSize: 16,
              value: typedField.initialValue,
              items: typedField.items.map((item) {
                return DropdownMenuItem<String>(
                  value: item[typedField.field],
                  child: Text(item[typedField.field]),
                );
              }).toList(),
              onChanged: typedField.onChanged,
              underline: Container(),
            ),
          ));
          break;
      }
      
      fieldsList.add(const SizedBox(height: 20,));
    }

    fieldsList.add(getFooter());

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: formKey,
        child: Column(children: fieldsList),
      ),
    );
  }

  Widget getFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ButtonWidget(
          icon: Icons.cancel,
          onTap: onClearForm,
          title: 'Clear',
          isLight: true,
        ),
        const SizedBox(width: 20,),
        ButtonWidget(
          icon: Icons.save,
          onTap: onSaveForm,
          title: 'Save',
        ),
      ],
    );
  }
}