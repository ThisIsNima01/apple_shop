import 'package:apple_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop/bloc/authentication/auth_event.dart';
import 'package:apple_shop/bloc/authentication/auth_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/main.dart';
import 'package:apple_shop/screens/base_screen.dart';
import 'package:apple_shop/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameTextController = TextEditingController(text: 'nimanaderi');

  final _passwordTextController = TextEditingController(text: 'nima8484');

  final _passwordConfirmTextController =
      TextEditingController(text: 'nima8484');

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
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  Image.asset(
                    'assets/images/register.jpg',
                    height: 200.h,
                    width: 200.w,
                  ),
                  Text(
                    'ساخت حساب کاربری',
                    style: TextStyle(
                      fontFamily: 'SM',
                      fontWeight: FontWeight.w700,
                      fontSize: 32.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
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
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تکرار رمز عبور:',
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
                            controller: _passwordConfirmTextController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthResponseState) {
                            state.response.fold((l) {
                              final snackbar = SnackBar(
                                content: Text(
                                  l,
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize: 16.sp,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(milliseconds: 1500),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            }, (r) {
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
                                textStyle: TextStyle(
                                    fontFamily: 'SB', fontSize: 20.sp),
                                minimumSize: const Size(200, 50),
                                backgroundColor: CustomColors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                              ),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                  AuthRegisterEvent(
                                    _usernameTextController.text,
                                    _passwordTextController.text,
                                    _passwordConfirmTextController.text,
                                  ),
                                );
                              },
                              child: const Text('ساخت حساب'),
                            );
                          }

                          if (state is AuthLoadingState) {
                            return const CircularProgressIndicator();
                          }

                          if (state is AuthResponseState) {
                            Widget widget = const Text('');

                            state.response.fold((l) {
                              widget = ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontFamily: 'SB', fontSize: 20.sp),
                                  minimumSize: const Size(200, 50),
                                  backgroundColor: CustomColors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                ),
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    AuthRegisterEvent(
                                      _usernameTextController.text,
                                      _passwordTextController.text,
                                      _passwordConfirmTextController.text,
                                    ),
                                  );
                                },
                                child: const Text('ساخت حساب'),
                              );
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
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'اگر حساب کاربری دارید وارد شوید',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ],
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
