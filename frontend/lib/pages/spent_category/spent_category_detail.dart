import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spenttracking/common/my_theme.dart';

import '../../controllers/spent_category_controller.dart';

class SpentCategoryDetail extends StatefulWidget {
  const SpentCategoryDetail({super.key});

  @override
  State<SpentCategoryDetail> createState() => _SpentCategoryDetailState();
}

class _SpentCategoryDetailState extends State<SpentCategoryDetail> {
  final categoryController = Get.find<SpentCategoryController>();
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Category Detail"),
      content: SizedBox(
        width: 540, // Change as per your requirement
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Id:",
                  style: TextStyle(color: MyTheme.primaryDark, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  categoryController.selectedSpentCategory.value["IdSpentCategory"].toString(),
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
              ListTile(
                title: Text(
                  "Description:",
                  style: TextStyle(color: MyTheme.primaryDark, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  categoryController.selectedSpentCategory.value["Description"].toString(),
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
              ListTile(
                title: Text(
                  "Register date:",
                  style: TextStyle(color: MyTheme.primaryDark, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  categoryController.selectedSpentCategory.value["RegisterDate"].toString(),
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}