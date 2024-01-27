import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/spent_service.dart';
import '../../services/spent_status_service.dart';
import '../../services/spent_category_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final spentCategoryService = Get.put(SpentCategoryService());
  final spentStatusService = Get.put(SpentStatusService());
  final spentService = Get.put(SpentService());

  @override
  void initState() {
    spentService
      .get()
      .then((result) => debugPrint(result.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Text("Hello World");
  }
}