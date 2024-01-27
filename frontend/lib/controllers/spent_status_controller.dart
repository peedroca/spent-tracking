import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../pages/spent/spent.dart';
import '../pages/spent_status/spent_status_detail.dart';
import '../pages/spent_status/spent_status_form.dart';
import '../services/spent_status_service.dart';

class SpentStatusController extends GetxController {
  final spentStatusService = Get.find<SpentStatusService>();
  final pagingController = PagingController(firstPageKey: 1);
  final searchController = SearchController();

  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();

  var spentStatusList = [].obs;
  var selectedSpentStatus = Rx<Map<String, dynamic>>({});

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
    spentStatusList.value = await spentStatusService.get();
    updateList();
  }

  Future handleDetail(index, data) async {
    selectedSpentStatus.value = await spentStatusService.getById(data["IdSpentStatus"]);
    await Get.dialog(
      const SpentStatusDetail(),
    );
  }

  Future handleDelete(index, data) async {
    await spentStatusService.delete(data["IdSpentStatus"])
      .then((value) async => await fetchData());

    Get.snackbar('Delete spentStatus', 'Deleting your spentStatus...');
  }

  Future handleSave() async {
    if (formKey.currentState!.validate()) {
      Future<dynamic> action = selectedSpentStatus.value["IdSpentStatus"] != null 
        ? spentStatusService.update(selectedSpentStatus.value["IdSpentStatus"], descriptionController.text)
        : spentStatusService.create(descriptionController.text);
      
      await action.then((value) => Get.snackbar('Sending data', 'Saved your spentStatus!'));
      
      await fetchData()
        .then((value) => Get.offAll(const SpentPage()));
    }
  }

  void onOpenCreateForm() {
    onClearForm();
    Get.to(const SpentStatusForm());
  }

  void onOpenEditForm(index, data) {
    onClearForm();
    
    selectedSpentStatus.value = data;
    descriptionController.text = data["Description"];
    Get.to(const SpentStatusForm());
  }

  void onClearForm() {
    descriptionController.text = "";
  }

  void updateList() {
    String? filter = searchController.text.toLowerCase();
    var filteredItens = spentStatusList
        .where((element) =>
            element["Description"].toLowerCase().contains(filter))
        .toList();

    pagingController.itemList = filteredItens;
    pagingController.nextPageKey = null;
  }
}