import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spenttracking/widgets/button/button_widget.dart';

import '../../common/my_theme.dart';
import '../../controllers/spent_controller.dart';
import '../../widgets/datagrid/datagrid_widget.dart';
import '../../widgets/datagrid/models/action_option.dart';
import '../../widgets/datagrid/models/datagrid.dart';
import '../../widgets/datagrid/models/datagrid_status.dart';
import '../../widgets/search_bar/search_bar_widget.dart';
import '../spent_category/spent_category.dart';
import '../spent_status/spent_status.dart';

class SpentPage extends StatefulWidget {
  const SpentPage({super.key});

  @override
  State<SpentPage> createState() => _SpentPageState();
}

class _SpentPageState extends State<SpentPage> {
  final spentController = Get.put(SpentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: MyTheme.primary,
        backgroundColor: MyTheme.primaryDark,
        title: Text("Spent Page", style: TextStyle(color: MyTheme.primary),),
      ),
      backgroundColor: MyTheme.primary,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarWidget(
                searchController: spentController.searchController, fetchData: spentController.fetchData),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWidget(
                    onTap: () async => await spentController.updateAllToPending(), 
                    icon: Icons.pending, 
                    title: "To pending",
                    isLight: true,
                  ),
                  const SizedBox(width: 5,),
                  ButtonWidget(
                    onTap: () => Get.to(const SpentStatusPage()), 
                    icon: Icons.check, 
                    title: "Status",
                    isLight: true,
                  ),
                  const SizedBox(width: 5,),
                  ButtonWidget(
                    onTap: () => Get.to(const SpentCategoryPage()), 
                    icon: Icons.category, 
                    title: "Category",
                    isLight: true,
                  ),
                  const SizedBox(width: 5,),
                  ButtonWidget(
                    onTap: () async => await spentController.fetchData(), 
                    icon: Icons.sync, 
                    title: "Sync",
                    isLight: true,
                  ),
                  const SizedBox(width: 5,),
                  ButtonWidget(
                    onTap: spentController.onOpenCreateForm, 
                    icon: Icons.add, 
                    title: "New"
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              DatagridWidget(
                pagingController: spentController.pagingController,
                items: [
                  Datagrid(title: "Category", field: "Category", flex: 2, onTap: () {}),
                  Datagrid(title: "Description", field: "Description", flex: 2, onTap: () {}),
                  Datagrid(title: "Amount", field: "Amount", flex: 1, onTap: () {}),
                  DatagridStatus(
                    title: "Status",
                    field: "Status",
                    flex: 1,
                    onTap: () {},
                    getIcon: (data) => spentController.getIconByStatus(data),
                    getIconColor: (data) => spentController.getColorByStatus(data)),
                ],
                actions: [
                  ActionOption(
                    title: "Detail",
                    icon: Icons.info,
                    onTap: spentController.handleDetail),
                  ActionOption(title: "Edit", icon: Icons.edit, onTap: spentController.onOpenEditForm),
                  ActionOption(title: "Delete", icon: Icons.delete, onTap: spentController.handleDelete),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}