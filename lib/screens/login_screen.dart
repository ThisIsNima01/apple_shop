import 'package:apple_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop/bloc/authentication/auth_event.dart';
import 'package:apple_shop/bloc/authentication/auth_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/main.dart';
import 'package:apple_shop/screens/base_screen.dart';
import 'package:apple_shop/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameTextController = TextEditingController();

  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final authBloc = AuthBloc();
        // authBloc.stream.forEach((state) {
        //   if (state is AuthResponseState) {
        //     state.response.fold((l) {}, (r) {
        //       globalNavigatorKey.currentState?.pushReplacement(
        //         MaterialPageRoute(
        //           builder: (context) => const BaseScreen(),
        //         ),
        //       );
        //     });
        //   }
        // });

        return authBloc;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  Image.asset(
                    'assets/images/login_photo.jpg',
                    height: 200.h,
                    width: 200.w,
                  ),
                  Text(
                    'ورود به حساب',
                    style: TextStyle(
                      fontFamily: 'SM',
                      fontWeight: FontWeight.w700,
                      fontSize: 34.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'نام کاربری:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                          color: Colors.grey[300],
                          child: TextField(
                            controller: _usernameTextController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'رمز عبور:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                          color: Colors.grey[300],
                          child: TextField(
                            obscureText: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: _passwordTextController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthResponseState) {
                        state.response.fold((l) => null, (r) {
                          globalNavigatorKey.currentState?.pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const BaseScreen(),
                            ),
                          );
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthInitState) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle:
                                TextStyle(fontFamily: 'SB', fontSize: 20.sp),
                            minimumSize: const Size(200, 50),
                            backgroundColor: CustomColors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(
                                AuthLoginEvent(_usernameTextController.text,
                                    _passwordTextController.text));
                          },
                          child: const Text('ورود به حساب کاربری'),
                        );
                      }

                      if (state is AuthLoadingState) {
                        return const CircularProgressIndicator();
                      }

                      if (state is AuthResponseState) {
                        Text widget = const Text('');

                        state.response.fold((l) {
                          widget = Text(l);
                        }, (r) {
                          widget = Text(r);
                        });

                        return widget;
                      }

                      return const Text('خطای نامشخص');
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'اگر حساب ندارید ثبت نام کنید',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
