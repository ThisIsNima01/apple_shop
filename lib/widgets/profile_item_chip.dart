import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileItemChip extends StatelessWidget {
  final String title;
  final int index;

  const ProfileItemChip({Key? key, required this.title,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        GestureDetector(
          onTap: () async{
            if (index == 10) {

            await launchUrl(Uri.parse('https://github.com/NimaNaderi'),mode: LaunchMode.externalApplication);
            }
          },
          child: Container(
            height: 56.h,
            width: 56.h,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: index == 10 ? Colors.black : theme.colorScheme.primary,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(40.r),
              ),
            ),
            child: index == 10 ? RippleAnimation(
              repeat: true,
              color: Colors.black,
              minRadius: 20,
              ripplesCount: 8,
              child: SvgPicture.asset(
                'assets/images/profile/$index.svg',
                color: theme.colorScheme.onPrimary,
              ),
            ) : SvgPicture.asset(
              'assets/images/profile/$index.svg',
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          title,
          style: theme.textTheme.bodySmall!.copyWith(color: Colors.black),
        )
      ],
    );
  }
}
