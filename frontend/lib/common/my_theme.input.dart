import 'package:flutter/material.dart';

import '../common/my_theme.dart';

class MyThemeInputs {
  static InputDecoration textInput = InputDecoration(
    labelStyle: TextStyle(color: MyTheme.primaryDark),
    errorBorder: OutlineInputBorder(
      borderRadius: MyTheme.borderRadius,
      borderSide: BorderSide(
        color: MyTheme.error,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: MyTheme.borderRadius,
      borderSide: BorderSide(
        color: MyTheme.error,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: MyTheme.borderRadius,
      borderSide: BorderSide(
        color: MyTheme.primaryDark,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: MyTheme.borderRadius,
      borderSide: BorderSide(
        color: MyTheme.primaryDark.withOpacity(0.3),
        width: 2.0,
      ),
    ),
    prefixIconColor:
        MaterialStateColor.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.focused)) {
        return MyTheme.primaryDark;
      }
      if (states.contains(MaterialState.error)) {
        return MyTheme.error;
      }
      return MyTheme.primaryDark.withOpacity(0.3);
    }),
  );
}