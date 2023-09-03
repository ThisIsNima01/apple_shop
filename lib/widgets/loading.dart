import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../config/theme/app_colors.dart';

// class LoadingItems extends StatelessWidget {
//   final String title;
//   const LoadingItems({Key? key, required this.title}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         LoadingAnimationWidget.beat(
//             color: theme.primaryColor, size: 32),
//         const SizedBox(
//           height: 16,
//         ),
//         Text(
//           title,
//           style: theme.textTheme.bodyMedium,
//         )
//       ],
//     );
//   }
// }
class LoadingItems extends StatelessWidget {
  const LoadingItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 60,
      width: 60,
      child: Center(
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          colors: [
            AppColors.primaryColor,
          ],
        ),
      ),
    );
  }
}
