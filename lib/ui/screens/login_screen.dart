import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Size size;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: size.width,
          height: size.height,
          color: Color(0xffF5F6FA),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                /*Container(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: size.width * 0.45,
                    //height: size.height * 0.3,
                  ),
                ),*/
                Container(
                  width: size.width,
                  height: size.height * 0.17,
                  //color: Color(0xff243B82),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Center(
                        child: Text(
                          'Welcome Back!',
                          style: TextStyle(
                              fontSize: 25.sp,
                              letterSpacing: 1.3,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Center(
                        child: Text(
                          'Sign in to access your MosquePay account',
                          style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8c939a)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff1C4ED8)
                              .withOpacity(0.15), // Shadow color
                          spreadRadius: 0, // Spread radius of the shadow
                          blurRadius: 10, // Blur radius of the shadow
                          offset: Offset(0, 3), // Offset of the shadow
                        ),
                      ]),
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  // decoration: BoxDecoration(
                  //     //color: Colors.grey[200],
                  //   border: Border.all(color: Color(0xff676a6b), width: 1),
                  //     borderRadius: BorderRadius.circular(7.r)),
                  child: Center(
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        focusedBorder: new OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffb9b9b9)),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        labelText: "Email",
                        // labelStyle: ,
                        //hintText: 'Email',
                        hintStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Color(0xffb9b9b9),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.07,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff1C4ED8)
                              .withOpacity(0.15), // Shadow color
                          spreadRadius: 0, // Spread radius of the shadow
                          blurRadius: 10, // Blur radius of the shadow
                          offset: Offset(0, 3), // Offset of the shadow
                        ),
                      ]),

                  // decoration: BoxDecoration(
                  //     //color: Colors.grey[200],
                  //   border: Border.all(color: Color(0xff676a6b), width: 1),
                  //     borderRadius: BorderRadius.circular(7.r)),
                  child: Center(
                    child: TextFormField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color(0xffb9b9b9),
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        border: InputBorder.none,
                        focusedBorder: new OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffb9b9b9)),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        labelText: "Password",
                        hintStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Color(0xffb9b9b9),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  width: size.width,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffEAB305)),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                //Sign in button
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
                  },
                  child: Container(
                    width: size.width,
                    height: size.height * 0.07,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                        color: Color(0xff1C4ED8),
                        borderRadius: BorderRadius.circular(50.r)),
                    child: Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
