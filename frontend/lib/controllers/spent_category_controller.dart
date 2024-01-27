import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:spenttracking/pages/spent_category/spent_category_detail.dart';
import 'package:spenttracking/pages/spent_category/spent_category_form.dart';
import 'package:spenttracking/services/spent_category_service.dart';

import '../pages/spent/spent.dart';

class SpentCategoryController extends GetxController {
  final spentCategoryService = Get.find<SpentCategoryService>();
  final pagingController = PagingController(firstPageKey: 1);
  final searchController = SearchController();

  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();

  var categories = [].obs;
  var selectedSpentCategory = Rx<Map<String, dynamic>>({});

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Future fetchData() async {
    categories.value = await spentCategoryService.get();
    updateList();
  }

  Future handleDetail(index, data) async {
    selectedSpentCategory.value = await spentCategoryService.getById(data["IdSpentCategory"]);
    await Get.dialog(
      const SpentCategoryDetail(),
    );
  }

  Future handleDelete(index, data) async {
    await spentCategoryService.delete(data["IdSpentCategory"])
      .then((value) async => await fetchData());

    Get.snackbar('Delete category', 'Deleting your category...');
  }

  Future handleSave() async {
    if (formKey.currentState!.validate()) {
      Future<dynamic> action = selectedSpentCategory.value["IdSpentCategory"] != null 
        ? spentCategoryService.update(selectedSpentCategory.value["IdSpentCategory"], descriptionController.text)
        : spentCategoryService.create(descriptionController.text);
      
      await action.then((value) => Get.snackbar('Sending data', 'Saved your category!'));
      
      await fetchData()
        .then((value) => Get.offAll(const SpentPage()));
    }
  }

  void onOpenCreateForm() {
    onClearForm();
    Get.to(const SpentCategoryForm());
  }

  void onOpenEditForm(index, data) {
    onClearForm();
    
    selectedSpentCategory.value = data;
    descriptionController.text = data["Description"];
    Get.to(const SpentCategoryForm());
  }

  void onOpenDetail(index, data) {

  }

  void onClearForm() {
    descriptionController.text = "";
  }

  void updateList() {
    String? filter = searchController.text.toLowerCase();
    var filteredItens = categories
        .where((element) =>
            element["Description"].toLowerCase().contains(filter))
        .toList();

    pagingController.itemList = filteredItens;
    pagingController.nextPageKey = null;
  }
}