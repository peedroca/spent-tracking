import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spenttracking/common/my_theme.dart';

import '../../controllers/spent_controller.dart';

class SpentDetail extends StatefulWidget {
  const SpentDetail({super.key});

  @override
  State<SpentDetail> createState() => _SpentDetailState();
}

class _SpentDetailState extends State<SpentDetail> {
  final spentController = Get.find<SpentController>();
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Spent Detail"),
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
                  spentController.selectedSpent.value["IdSpent"].toString(),
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
              ListTile(
                title: Text(
                  "Category:",
                  style: TextStyle(color: MyTheme.primaryDark, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  spentController.selectedSpent.value["spentcategory"]["Description"].toString(),
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
              ListTile(
                title: Text(
                  "Status:",
                  style: TextStyle(color: MyTheme.primaryDark, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  spentController.selectedSpent.value["spentstatus"]["Description"].toString(),
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
                  spentController.selectedSpent.value["Description"].toString(),
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
                  spentController.selectedSpent.value["RegisterDate"].toString(),
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