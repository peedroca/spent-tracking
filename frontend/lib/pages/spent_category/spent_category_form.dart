import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spenttracking/controllers/spent_category_controller.dart';
import 'package:spenttracking/widgets/formulary/models/formulary_text_field.dart';

import '../../common/my_theme.dart';
import '../../widgets/formulary/formulary_widget.dart';
import 'spent_category_form.validations.dart';

class SpentCategoryForm extends StatefulWidget {
  const SpentCategoryForm({super.key});

  @override
  State<SpentCategoryForm> createState() => _SpentCategoryFormState();
}

class _SpentCategoryFormState extends State<SpentCategoryForm> {
  final categoryController = Get.find<SpentCategoryController>();

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.primaryDark,
        foregroundColor: MyTheme.primary,
        title: Text("Category Form", style: TextStyle(color: MyTheme.primary),),
      ),
      backgroundColor: MyTheme.primary,
      body: FormularyWidget(
        formKey: categoryController.formKey,
        fields: [
          FormularyTextField(
            SpentCategoryFormValidations.descriptionValidation, 
            icon: Icons.description, 
            title: 'Description', 
            controller: categoryController.descriptionController
          ),
        ],
        onClearForm: categoryController.onClearForm,
        onSaveForm: categoryController.handleSave,
      ),
    );
  }
}
