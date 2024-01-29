import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spenttracking/widgets/formulary/models/formulary_dropdown_field.dart';
import 'package:spenttracking/widgets/formulary/models/formulary_small_help.dart';
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
      body: Obx(() =>
        FormularyWidget(
          formKey: spentController.formKey,
          fields: [
            FormularySmallHelp(helpText: "Select a category for your spent..."),
            FormularyDropdownField(
              initialValue: spentController.selectedCategory.value,
              items: spentController.spentCategoryList,
              field: "Description",
              onChanged: spentController.onChangedCategory,
              icon: Icons.category,
              title: 'Description',
            ),
            FormularySmallHelp(helpText: "And a initial status"),
            FormularyDropdownField(
              initialValue: spentController.selectedStatus.value,
              items: spentController.spentStatusList,
              field: "Description",
              onChanged: spentController.onChangedStatus,
              icon: Icons.check,
              title: 'Description',
            ),
            FormularySmallHelp(helpText: "Now, describe your spent:"),
            FormularyTextField(
              SpentFormValidations.descriptionValidation,
              icon: Icons.description,
              title: 'Description',
              controller: spentController.descriptionController
            ),
            FormularyTextField(
              SpentFormValidations.descriptionValidation,
              icon: Icons.paid,
              title: 'Amount',
              controller: spentController.amountController
            ),
          ],
          onClearForm: spentController.onClearForm,
          onSaveForm: spentController.handleSave,
        ),
      ),
    );
  }
}
