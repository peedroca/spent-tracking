import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spenttracking/controllers/spent_category_controller.dart';
import 'package:spenttracking/widgets/button/button_widget.dart';

import '../../common/my_theme.dart';
import '../../widgets/datagrid/datagrid_widget.dart';
import '../../widgets/datagrid/models/action_option.dart';
import '../../widgets/datagrid/models/datagrid.dart';
import '../../widgets/search_bar/search_bar_widget.dart';

class SpentCategoryPage extends StatefulWidget {
  const SpentCategoryPage({super.key});

  @override
  State<SpentCategoryPage> createState() => _SpentCategoryPageState();
}

class _SpentCategoryPageState extends State<SpentCategoryPage> {
  final categoryController = Get.put(SpentCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.primaryDark,
        foregroundColor: MyTheme.primary,
        title: Text("Category Page", style: TextStyle(color: MyTheme.primary),),
      ),
      backgroundColor: MyTheme.primary,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarWidget(
                searchController: categoryController.searchController, fetchData: categoryController.fetchData),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWidget(
                    onTap: categoryController.onOpenCreateForm, 
                    icon: Icons.add, 
                    title: "New"
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              DatagridWidget(
                pagingController: categoryController.pagingController,
                items: [
                  Datagrid(title: "Description", field: "Description", flex: 2, onTap: () {}),
                ],
                actions: [
                  ActionOption(
                    title: "Detail",
                    icon: Icons.info,
                    onTap: categoryController.handleDetail),
                  ActionOption(title: "Edit", icon: Icons.edit, onTap: categoryController.onOpenEditForm),
                  ActionOption(title: "Delete", icon: Icons.delete, onTap: categoryController.handleDelete),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}