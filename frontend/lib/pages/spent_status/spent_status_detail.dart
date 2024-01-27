import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spenttracking/common/my_theme.dart';

import '../../controllers/spent_status_controller.dart';

class SpentStatusDetail extends StatefulWidget {
  const SpentStatusDetail({super.key});

  @override
  State<SpentStatusDetail> createState() => _SpentStatusDetailState();
}

class _SpentStatusDetailState extends State<SpentStatusDetail> {
  final spentStatusController = Get.find<SpentStatusController>();
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("SpentStatus Detail"),
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
                  spentStatusController.selectedSpentStatus.value["IdSpentStatus"].toString(),
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
                  spentStatusController.selectedSpentStatus.value["Description"].toString(),
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
                  spentStatusController.selectedSpentStatus.value["RegisterDate"].toString(),
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