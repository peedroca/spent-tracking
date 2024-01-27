import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spenttracking/widgets/formulary/models/formulary_text_field.dart';

import '../../common/my_theme.dart';
import '../../controllers/spent_controller.dart';
import '../../widgets/formulary/formulary_widget.dart';
import 'spent_form.validations.dart';

class SpentForm extends StatefulWidget {
  const SpentForm({super.key});

  @override
  State<SpentForm> createState() => _SpentFormState();
}

class _SpentFormState extends State<SpentForm> {
  final spentController = Get.find<SpentController>();

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.primaryDark,
        foregroundColor: MyTheme.primary,
        title: Text("Spent Form", style: TextStyle(color: MyTheme.primary),),
      ),
      backgroundColor: MyTheme.primary,
      body: FormularyWidget(
        formKey: spentController.formKey,
        fields: [
          FormularyTextField(
            SpentFormValidations.descriptionValidation, 
            icon: Icons.description, 
            title: 'Description', 
            controller: spentController.descriptionController
          ),
        ],
        onClearForm: spentController.onClearForm,
        onSaveForm: spentController.handleSave,
      ),
    );
  }
}
