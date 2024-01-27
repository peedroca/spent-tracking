import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spenttracking/widgets/formulary/models/formulary_text_field.dart';

import '../../common/my_theme.dart';
import '../../controllers/spent_status_controller.dart';
import '../../widgets/formulary/formulary_widget.dart';
import 'spent_status_form.validations.dart';

class SpentStatusForm extends StatefulWidget {
  const SpentStatusForm({super.key});

  @override
  State<SpentStatusForm> createState() => _SpentStatusFormState();
}

class _SpentStatusFormState extends State<SpentStatusForm> {
  final spentStatusController = Get.find<SpentStatusController>();

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.primaryDark,
        foregroundColor: MyTheme.primary,
        title: Text("SpentStatus Form", style: TextStyle(color: MyTheme.primary),),
      ),
      backgroundColor: MyTheme.primary,
      body: FormularyWidget(
        formKey: spentStatusController.formKey,
        fields: [
          FormularyTextField(
            SpentStatusFormValidations.descriptionValidation, 
            icon: Icons.description, 
            title: 'Description', 
            controller: spentStatusController.descriptionController
          ),
        ],
        onClearForm: spentStatusController.onClearForm,
        onSaveForm: spentStatusController.handleSave,
      ),
    );
  }
}
