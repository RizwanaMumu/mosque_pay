import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:m_toast/m_toast.dart';


class CommonFunctions {

  loader(BuildContext context) {
    showDialog(
        barrierColor: Colors.white54,
        context: context,
        barrierDismissible: false,
        useSafeArea: false,
        builder: (context) =>
            WillPopScope(
              onWillPop: () async => false,
              child: Container(
                width: 50.w,
                height: 50.h,
                child: LoadingAnimationWidget.threeArchedCircle(
                    color: Color(0xff2464B3), size: 35),
              ),
            ));
  }

  showErrorToast(BuildContext context, String message){
    ShowMToast toast = ShowMToast();
    toast.errorToast(context, message: message, alignment: Alignment.bottomCenter);
  }
  showSuccessToast(BuildContext context, String message){
    ShowMToast toast = ShowMToast();
    toast.successToast(context, message: message, alignment: Alignment.bottomCenter);
  }
}
