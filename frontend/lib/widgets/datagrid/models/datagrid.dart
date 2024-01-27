class Datagrid {
  final String title;
  final String field;
  final int flex;
  final void Function()? onTap;

  Datagrid({required this.title, required this.field, required this.flex, required this.onTap});
}