import 'package:flutter/material.dart';
import 'package:spenttracking/widgets/formulary/models/formulary_field.dart';

import '../../common/my_theme.input.dart';
import '../button/button_widget.dart';
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
      }
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
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
      ),
    );
  }
}