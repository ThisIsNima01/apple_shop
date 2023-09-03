import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
class ProjectAppBar extends StatelessWidget {
  final String appbarTitle;
   const ProjectAppBar({Key? key, required this.appbarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: 46.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 16.w,
          ),
          SvgPicture.asset('assets/icons/apple.svg',
              color: theme.colorScheme.primary, width: 24.w),
          Expanded(
            child: Text(
              appbarTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
      ),
    );
  }
}
