import 'package:flutter/widgets.dart';
import './datagrid.dart';

class DatagridStatus extends Datagrid {
  final IconData Function(dynamic data)? getIcon;
  final Color Function(dynamic data)? getIconColor;

  DatagridStatus({
    required super.title,
    required super.field,
    required super.flex,
    required super.onTap,
    required this.getIcon,
    required this.getIconColor,
  });
}