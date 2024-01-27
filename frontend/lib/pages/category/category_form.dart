import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spenttracking/controllers/category_controller.dart';

import '../../common/my_theme.dart';
import '../../common/my_theme.input.dart';
import './category_form.validations.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.primaryDark,
        title: Text("Category Form", style: TextStyle(color: MyTheme.primary),),
      ),
      backgroundColor: MyTheme.primary,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: categoryController.formKey,
          child: Column(children: <Widget>[
            TextFormField(
              controller: categoryController.descriptionController,
              validator: CategoryFormValidations.descriptionValidation,
              decoration: MyThemeInputs.textInput.copyWith(
                labelText: 'Description',
                prefixIcon: const Icon(Icons.description),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: categoryController.onCancel,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
                      backgroundColor: Colors.white,
                      foregroundColor: MyTheme.highlight,
                      shape: RoundedRectangleBorder(
                        borderRadius: MyTheme.borderRadius,
                        side: BorderSide(color: MyTheme.highlight, width: 2)
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: categoryController.onSubmit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
                      backgroundColor: MyTheme.highlight,
                      foregroundColor: MyTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: MyTheme.borderRadius,
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
