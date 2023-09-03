import 'package:apple_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop/bloc/authentication/auth_event.dart';
import 'package:apple_shop/bloc/authentication/auth_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: CustomColors.blue,
          body: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon_application.png',
                      width: 100.w,
                      height: 100.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'اپل شاپ',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 24.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.h,right: 20.w,left: 20.w,top: 18.h),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _usernameTextController,
                        decoration: InputDecoration(
                          labelText: 'نام کاربری',
                          labelStyle: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18.sp,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide:
                            const BorderSide(color: CustomColors.blue, width: 3),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        controller: _passwordTextController,
                        decoration: InputDecoration(
                          labelText: 'رمز عبور',
                          labelStyle: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18.sp,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide:const BorderSide(
                                color: Colors.black, width: 3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide:
                            const BorderSide(color: CustomColors.blue, width: 3),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthInitState) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontFamily: 'SB', fontSize: 18.sp),
                                  minimumSize: const Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                  )),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                    AuthLoginRequest(
                                        _usernameTextController.text,
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
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
