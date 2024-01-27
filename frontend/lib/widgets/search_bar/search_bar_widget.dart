import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final void Function() fetchData;
  const SearchBarWidget({super.key, required this.searchController, required this.fetchData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width / 5,
          child: TextFormField(
            controller: searchController,
            onChanged: (value) {
              Future.delayed(const Duration(microseconds: 1000), () {
                fetchData();
              });
            },
            onEditingComplete: () {
              Future.delayed(const Duration(microseconds: 1000), () {
                fetchData();
              });
            },
            onFieldSubmitted: (v) {
              Future.delayed(const Duration(microseconds: 1000), () {
                fetchData();
              });
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "${"lbl_search".tr}..",
              contentPadding: const EdgeInsets.only(left: 10),
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}