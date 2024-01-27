import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spenttracking/services/spent_category_service.dart';

class CategoryController extends GetxController {
  final spentCategoryService = Get.put(SpentCategoryService());

  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Future onSubmit() async {
    if (formKey.currentState!.validate()) {
      await spentCategoryService.create(descriptionController.text).then((value) async {
        //formKey.currentState!.reset();
        await Get.snackbar('Sending data', 'Saved your category!').show();
      });
    }
  }

  void onCancel() {
    formKey.currentState!.reset();
  }
}