import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spenttracking/common/my_theme.dart';
import './models/datagrid.dart';
import './models/datagrid_status.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'models/action_option.dart';

class DatagridWidget extends StatefulWidget {
  final PagingController pagingController;
  final List<Datagrid> items;
  final List<ActionOption>? actions;
  final List<ActionOption>? footerButtons;
  const DatagridWidget(
      {super.key, required this.pagingController, required this.items, this.actions, this.footerButtons});

  @override
  State<DatagridWidget> createState() => _DatagridWidgetState();
}

class _DatagridWidgetState extends State<DatagridWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool useGrid = true;
    if (screenWidth < 900) {
      useGrid = false;
    }

    return Column(children: [
      useGrid
          ? Column(
              children: [
                _getHeader(),
                Divider(
                  thickness: 2,
                  color: MyTheme.primaryDark,
                ),
              ],
            )
          : const SizedBox(),
      _getBody(useGrid),
      _getFooter(),
    ]);
  }

  Widget _getHeader() {
    List<Widget> items = [];
    for (Datagrid dg in widget.items) {
      items.add(_getTitle(dg.title, dg.flex, dg.onTap));
    }

    // Includes a space on header to add options on body
    if (widget.actions != null) {
      items.add(const Spacer());
    }

    return Row(
      children: items,
    );
  }

  Widget _getBody(bool useGrid) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: PagedListView.separated(
        pagingController: widget.pagingController,
        builderDelegate: PagedChildBuilderDelegate(itemBuilder: useGrid ? getGridView : getCardView),
        separatorBuilder: (context, index) => Divider(
          thickness: 0.5,
          color: MyTheme.primaryDark,
        ),
      ),
    );
  }

  Widget getGridView(BuildContext context, Object? item, int index) {
    dynamic data = item;

    List<Widget> items = [];
    for (Datagrid dg in widget.items) {
      switch (dg.runtimeType) {
        case DatagridStatus:
          items.add(_getFieldWithIcon(data[dg.field], dg as DatagridStatus, dg.flex));
          break;
        default:
          items.add(_getField(data[dg.field], dg.flex));
      }
    }

    if (widget.actions != null) {
      List<PopupMenuItem<String>> options = [];
      for (ActionOption ao in widget.actions!) {
        options.add(_getOptionField(ao, index, data));
      }

      items.add(_getOption(options, 1));
    }

    return SizedBox(
      height: 40,
      child: Row(children: items),
    );
  }

  Widget getCardView(BuildContext context, Object? item, int index) {
    dynamic data = item;

    List<Widget> items = [];
    if (widget.actions != null) {
      List<PopupMenuItem<String>> options = [];
      for (ActionOption ao in widget.actions!) {
        options.add(_getOptionField(ao, index, data));
      }

      items.add(_getOptionCard(options, 1));
    }

    for (Datagrid dg in widget.items) {
      switch (dg.runtimeType) {
        case DatagridStatus:
          items.add(_getFieldCardWithIcon(data[dg.field], dg as DatagridStatus));
          break;
        default:
          items.add(_getFieldCard(dg, data));
      }
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * (widget.items.length / 8),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, right: 18.0),
        child: SingleChildScrollView(
          child: Column(
            children: items,
          ),
        ),
      ),
    );
  }

  Widget _getTitle(String title, int flex, void Function()? onTap) {
    return Expanded(
        flex: flex,
        child: SizedBox(
          height: 50,
          child: InkWell(
              onTap: onTap,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: MyTheme.primaryDark, fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      )))),
        ));
  }

  Widget _getField(dynamic data, int flex) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          data.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _getFieldCard(Datagrid dg, dynamic data) {
    return ListTile(
      title: Text(
        "${dg.title}:",
        style: TextStyle(color: MyTheme.primaryDark, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        data[dg.field].toString(),
        softWrap: true,
        maxLines: 2,
      ),
    );
  }

  Widget _getFieldCardWithIcon(dynamic data, DatagridStatus dgStatus) {
    return ListTile(
      title: Text(
        "${dgStatus.title}:",
        style: TextStyle(color: MyTheme.primaryDark, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Icon(
            dgStatus.getIcon!(data),
            size: 18,
            color: dgStatus.getIconColor!(data),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            data.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _getFieldWithIcon(dynamic data, DatagridStatus dgStatus, int flex) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Icon(
              dgStatus.getIcon!(data),
              size: 18,
              color: dgStatus.getIconColor!(data),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              data.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _getOptionField(ActionOption option, int index, dynamic data) {
    return PopupMenuItem<String>(
      value: option.title,
      onTap: () => option.onTap(index, data),
      child: Row(
        children: [
          Icon(option.icon),
          const SizedBox(
            width: 10,
          ),
          Text(option.title.tr, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _getOption(dynamic data, int flex) {
    return Expanded(
      flex: flex,
      child: PopupMenuButton(
        tooltip: "lbl_actiontypedesc".tr,
        itemBuilder: (_) => data,
        child: const Icon(Icons.more_vert),
      ),
    );
  }

  Widget _getOptionCard(dynamic data, int flex) {
    return Align(
      alignment: Alignment.centerRight,
      child: PopupMenuButton(
        tooltip: "lbl_actiontypedesc".tr,
        itemBuilder: (_) => data,
        child: const Icon(Icons.more_vert),
      ),
    );
  }

  SizedBox _getFooter() {
    List<Widget> buttons = [];
    if (widget.footerButtons != null) {
      for (ActionOption ao in widget.footerButtons!) {
        buttons.add(
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(ao.backgroundColor ?? Colors.green),
            ),
            onPressed: () => ao.onTap(0, null),
            icon: Icon(
              Icons.add,
              color: ao.textColor ?? Colors.white,
            ),
            label: Text(
              ao.title.tr,
              style: TextStyle(
                color: ao.textColor ?? Colors.white,
              ),
            ),
          ),
        );
      }
    }

    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: buttons,
        ),
      ),
    );
  }
}