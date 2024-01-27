import 'package:flutter/material.dart';

import '../../common/my_theme.dart';

class ButtonWidget extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final String title;
  final bool? isLight;

  const ButtonWidget({super.key, required this.onTap, required this.icon, required this.title, this.isLight = false});

  @override
  Widget build(BuildContext context) {
    return isLight ?? false
    ? ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
          backgroundColor: Colors.white,
          foregroundColor: MyTheme.primaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: MyTheme.borderRadius,
            side: BorderSide(color: MyTheme.primaryDark, width: 2)
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: MyTheme.primaryDark,),
            const SizedBox(width: 3,),
            Text(title, style: TextStyle(color: MyTheme.primaryDark, fontWeight: FontWeight.bold),)
          ],
        ),
      )
    : ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
          backgroundColor: MyTheme.primaryDark,
          foregroundColor: MyTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: MyTheme.borderRadius,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: MyTheme.primary,),
            const SizedBox(width: 3,),
            Text(title, style: TextStyle(color: MyTheme.primary, fontWeight: FontWeight.bold),)
          ],
        ),
      );
    // : InkWell(
    //     onTap: onTap, 
    //     borderRadius: MyTheme.borderRadius,
    //     child: ClipRRect(
    //       borderRadius: MyTheme.borderRadius,
    //       child: Container(
    //         color: MyTheme.primaryDark,
    //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    //         child: Row(
    //           children: [
    //             Icon(icon, color: MyTheme.primary,),
    //             const SizedBox(width: 6,),
    //             Text(title, style: TextStyle(color: MyTheme.primary, fontWeight: FontWeight.bold),)
    //           ],
    //         ),
    //       ),
    //     )
    //   );
  }
}