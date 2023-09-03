import 'package:apple_shop/config/theme/app_colors.dart';
import 'package:apple_shop/widgets/profile_item_chip.dart';
import 'package:apple_shop/widgets/project_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 44.w,
                right: 44.w,
                bottom: 32.h,
                top: 20.h,
              ),
              child: ProjectAppBar(appbarTitle: 'حساب کاربری'),
            ),
            Text(
              'نیما نادری',
              style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.onBackground),
            ),
            Text(
              '09102937012',
              style: theme.textTheme.labelSmall!.copyWith(color: AppColors.grey,fontFamily: 'SM'),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 44.w),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Wrap(
                  runSpacing: 26.h,
                  spacing: 36.w,
                  children: List.generate(
                      11,
                      (index) => ProfileItemChip(
                            title: index == 10 ? 'گیتهاب من' : 'گزینه ${index+1}',
                            index: index,
                          )),
                ),
              ),
            ),
            const Spacer(),
            Text(
              'اپل شاپ',
              style: theme.textTheme.labelSmall!.copyWith(color: AppColors.grey,fontFamily: 'SM'),
            ),
            Text(
              'v-2.0.00',
              style: theme.textTheme.labelSmall!.copyWith(color: AppColors.grey,fontFamily: 'SM'),
            ),
            Text(
              'Instagram.com/nima_n_i',
              style: theme.textTheme.labelSmall!.copyWith(color: AppColors.grey,fontFamily: 'SM'),
            ),
            SizedBox(
              height: 32.h,
            ),
          ],
        ),
      ),
    );
  }
}

// List<String> _getProfileChipData() => [
//       'تنظیمات',
//       'سفارشات اخیر',
//       'آدرس ها',
//       'علاقمندی ها',
//       'نقد و نظرات',
//       'تخفیف ها',
//       'سفارش درحال انجام',
//       'اطلاعیه',
//       'بلاگ',
//       'پشتیبانی',
//     ];
