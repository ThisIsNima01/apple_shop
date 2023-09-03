import 'package:apple_shop/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff58AEE8),
                Color(0xff3B5EDF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              const Expanded(child: _AppleShopLogo()),
              const Expanded(
                child: _BottomText(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomText extends StatelessWidget {
  const _BottomText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/welcome_pattern.png'),
          fit: BoxFit.contain,
          repeat: ImageRepeat.repeatY,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 44.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'اوج هیجان',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontFamily: 'SB',
                  ),
                ),
                Text(
                  'با خرید محصولات',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontFamily: 'SB',
                  ),
                ),
                Text(
                  '!اپل',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontFamily: 'SB',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 22.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const BaseScreen(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 44.w),
              padding: const EdgeInsets.all(16),
              height: 70.h,
              width: 70.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff253DEE),
              ),
              child: SvgPicture.asset('assets/icons/arrow-welcome.svg'),
            ),
          ),
          const Spacer(),
          Center(
            child: Column(
              children: [
                Text(
                  'From',
                  style: TextStyle(
                      color: const Color(0xff86A5F8),
                      fontSize: 12.sp,
                      fontFamily: 'GB'),
                ),
                Text('Nima Naderi',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontFamily: 'GB')),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

class _AppleShopLogo extends StatelessWidget {
  const _AppleShopLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 44.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 72.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 100.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 130.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 130.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/icons/logo.svg',
                height: 100.h,
                width: 84.w,
              ),
              SizedBox(height: 16.h),
              Text(
                'اپل شاپ',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'SB',
                  fontSize: 20.sp,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
