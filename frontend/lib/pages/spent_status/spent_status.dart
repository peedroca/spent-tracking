import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spenttracking/widgets/button/button_widget.dart';

import '../../common/my_theme.dart';
import '../../controllers/spent_status_controller.dart';
import '../../widgets/datagrid/datagrid_widget.dart';
import '../../widgets/datagrid/models/action_option.dart';
import '../../widgets/datagrid/models/datagrid.dart';
import '../../widgets/search_bar/search_bar_widget.dart';

class SpentStatusPage extends StatefulWidget {
  const SpentStatusPage({super.key});

  @override
  State<SpentStatusPage> createState() => _SpentStatusPageState();
}

class _SpentStatusPageState extends State<SpentStatusPage> {
  final spentStatusController = Get.put(SpentStatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.primaryDark,
        foregroundColor: MyTheme.primary,
        title: Text("SpentStatus Page", style: TextStyle(color: MyTheme.primary),),
      ),
      backgroundColor: MyTheme.primary,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarWidget(
                searchController: spentStatusController.searchController, fetchData: spentStatusController.fetchData),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWidget(
                    onTap: spentStatusController.onOpenCreateForm, 
                    icon: Icons.add, 
                    title: "New"
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              DatagridWidget(
                pagingController: spentStatusController.pagingController,
                items: [
                  Datagrid(title: "Description", field: "Description", flex: 2, onTap: () {}),
                ],
                actions: [
                  ActionOption(
                    title: "Detail",
                    icon: Icons.info,
                    onTap: spentStatusController.handleDetail),
                  ActionOption(title: "Edit", icon: Icons.edit, onTap: spentStatusController.onOpenEditForm),
                  ActionOption(title: "Delete", icon: Icons.delete, onTap: spentStatusController.handleDelete),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}