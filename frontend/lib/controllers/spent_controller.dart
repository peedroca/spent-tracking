import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../pages/spent/spent.dart';
import '../pages/spent/spent_detail.dart';
import '../pages/spent/spent_form.dart';
import '../services/spent_category_service.dart';
import '../services/spent_service.dart';
import '../services/spent_status_service.dart';

class SpentController extends GetxController {
  final spentService = Get.put(SpentService());
  final spentStatusService = Get.put(SpentStatusService());
  final spentCategoryService = Get.put(SpentCategoryService());

  final pagingController = PagingController(firstPageKey: 1);
  final searchController = SearchController();

  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  var spentList = [].obs;
  var spentStatusList = [].obs;
  var spentCategoryList = [].obs;

  var selectedSpent = Rx<Map<String, dynamic>>({});
  var selectedCategory = Rx<String?>(null);
  var selectedStatus = Rx<String?>(null);

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }

  Future fetchData() async {
    spentList.value = await spentService.get();
    spentStatusList.value = await spentStatusService.get();
    spentCategoryList.value = await spentCategoryService.get();

    updateList();
  }

  Future handleDetail(index, data) async {
    selectedSpent.value = await spentService.getById(data["IdSpent"]);
    await Get.dialog(
      const SpentDetail(),
    );
  }

  Future handleDelete(index, data) async {
    await spentService.delete(data["IdSpentSpent"])
      .then((value) async => await fetchData());

    Get.snackbar('Delete spent', 'Deleting your spent...');
  }

  Future handleSave() async {
    if (formKey.currentState!.validate()) {
      Future<dynamic> action = selectedSpent.value["IdSpent"] != null 
        ? spentService.update(selectedSpent.value["IdSpent"], 
            selectedCategory.value ?? "",
            selectedStatus.value ?? "",
            descriptionController.text,
            amountController.text
          )
        : spentService.create(
            selectedCategory.value ?? "",
            selectedStatus.value ?? "",
            descriptionController.text,
            amountController.text
          );
      
      await action.then((value) => Get.snackbar('Sending data', 'Saved your spent!'));
      
      await fetchData()
        .then((value) => Get.offAll(const SpentPage()));
    }
  }

  Future updateAllToPending() async {
    await spentService.updateAllToPending();
    await fetchData();
  }

  void onOpenCreateForm() {
    onClearForm();
    Get.to(const SpentForm());
  }

  void onOpenEditForm(index, data) {
    onClearForm();

    debugPrint(data.toString());
    
    selectedSpent.value = data;
    descriptionController.text = data["Description"];
    amountController.text = data["Amount"];
    selectedCategory.value = data["Category"];
    selectedStatus.value = data["Status"];

    Get.to(const SpentForm());
  }

  void onClearForm() {
    descriptionController.text = "";
    amountController.text = "";
    selectedCategory.value = spentCategoryList.first["Description"];
    selectedStatus.value = spentStatusList.first["Description"];
  }

  void updateList() {
    String? filter = searchController.text.toLowerCase();
    var filteredItens = spentList
        .where((element) =>
            element["Description"].toLowerCase().contains(filter) ||
            element["Amount"].toLowerCase().contains(filter) ||
            element["Status"].toLowerCase().contains(filter) ||
            element["Category"].toLowerCase().contains(filter)) 
        .toList();

    pagingController.itemList = filteredItens;
    pagingController.nextPageKey = null;
  }

  void onChangedCategory(dynamic description) {
    selectedCategory.value = description;
  }

  void onChangedStatus(dynamic description) {
    selectedStatus.value = description;
  }

  IconData getIconByStatus(dynamic data) {
    if (data == "Pago") {
      return Icons.check_circle;
    } else {
      return Icons.info;
    }
  }

  Color getColorByStatus(dynamic data) {
    if (data == "Pago") {
      return Colors.green;
    } else if (data == "Pendente") {
      return const Color.fromARGB(255, 209, 183, 55);
    } else {
      return Colors.blue;
    }
  }
}